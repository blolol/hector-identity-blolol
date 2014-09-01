spec = Gem::Specification.new do |s|
  s.name = 'hector-identity-blolol'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Ross Paffett']
  s.email = ['ross@rosspaffett.com']
  s.homepage = 'https://github.com/blolol/hector-identity-blolol'
  s.summary = 'Blolol identity adapter for Hector'
  s.description = 'An identity adapter that talks to the Blolol authentication API.'
  s.files = Dir['lib/**/*.rb']
  s.require_path = 'lib'

  s.add_dependency 'excon', '~> 0.37.0'
  s.add_dependency 'hector', '~> 1.0.9'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'webmock', '~> 1.18.0'
end
