module SecureEquals
  # Provides an equality method on strings that is not vulnerable to timing attacks.
  #
  # This prevents attackers from being able to guess the answer byte-by-byte using
  # tiny differences in response time.
  #
  # @param [String] The secret string
  # @param [String] The string provided by the user
  # @return [Boolean] Are the strings the same?
  #
  def self.equal?(mine, theirs)
    return false if mine.nil? || theirs.nil?
    mine = mine.to_str
    theirs = theirs.to_str
    return false unless mine.length == theirs.length

    difference = 0
    0.upto(mine.length - 1) do |i|
      difference |= (mine[i].ord ^ theirs[i].ord)
    end

    difference == 0
  end
end
