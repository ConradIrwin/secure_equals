Gem::Specification.new do |s|
  s.name = "secure_equals"
  s.version = "0.3.0"
  s.platform = Gem::Platform::RUBY
  s.author = "Conrad Irwin"
  s.email = "conrad.irwin@gmail.com"
  s.homepage = "http://github.com/Conradirwin/secure_equals"
  s.summary = "Provides constant time equality for ruby strings"
  s.description = "Constant time equality (also known as time insensitive equality) lets you compare user-provided strings with secrets in a way that does not leak data about those secrets."
  s.files = `git ls-files`.split("\n")
  s.require_path = "lib"
  a.license = 'MIT'
end
