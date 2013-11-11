require_relative '../lib/secure_equals'
require 'securerandom'
require 'hitimes'
GC.disable

class Box
  def initialize
    @secret = '0123456789abcdeffedcba0987654321'
  end

  # The expected score of a random guess is 0.5.
  # The expected score of the correct answer is 1.
  #
  # If you are able to get scores consistently higher
  # than 0.5 using only the guess method, then you
  # have a successful timing attack.
  def score(str)
    score = 0.0
    mine = @secret.each_byte.map{ |x| x.to_s(2) }.join
    theirs = str.each_byte.map{ |x| x.to_s(2) }.join

    mine.each_byte.zip(theirs.each_byte) do |a,b|
      score += 1 if a == b
    end
    (score / mine.length)
  end

  class Weak < Box
    def guess(str)
      0.upto(@secret.length - 1) do |i|
        return false unless @secret[i] == str[i]
      end
      true
    end
  end

  class Standard < Box
    def guess(str)
      @secret == str
    end
  end

  class Secure < Box
    def guess(str)
      SecureEquals.same? @secret, str
    end
  end
end

def brute_force(box, trials)
  scores = []
  1.times do
    guess = '0' * 32
    (0..32).each do |pos|
      max = 0
      result = nil
      this_time = guess.dup
      'abcdef0123456789'.each_char do |letter|
        this_time[pos] = letter
        time = Hitimes::Interval.measure do
          trials.times{ box.guess this_time }
        end
        if time > max
          max = time
          result = letter
        end
      end
      guess[pos] = result
    end
    scores << box.score(guess)
  end

  puts "average: #{scores.inject(&:+) / scores.size}"
end

10.times do
  brute_force Box::Weak.new, 1000
  brute_force Box::Standard.new, 100000
  brute_force Box::Secure.new, 1000000
end
