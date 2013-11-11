Secure equals provides a constant time equality method for ruby strings.

By avoiding any branches that depend on the similarity of the two strings,
we make it significantly harder for an attacker to discover properties of
the secret by observing the time it takes to run the comparison.

You should use this for checking checksums or shared secrets in your code.

## Installation

You can either `gem install secure_equals` or add `gem 'secure_equals'` to your Gemfile and then run `bundle install`

## Usage

```ruby
SecureEquals.equal? checksum, @params[:checksum]
```

## TODO

I was unable to implement a successful timing attack against ruby's string == on my Mac Book Pro; so while the code here looks promising, I've not actually been able to verify that it actually solves the problem.

We should try running the attack on 16- and 32- byte sized chunks instead of the character-by-character mode, as I suspect the problem is memcmp(). Alternatively there might be a way to get higher resolution timings, or to use some stats that I don't know about, to make it work.

## BUGS

I'm pretty sure this must already exist somewhere...
