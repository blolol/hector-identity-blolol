spec = Gem::Specification.new do |s|
  s.name = 'hector-identity-blolol'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Ross Paffett']
  s.email = ['ross@rosspaffett.com']
  s.homepage = 'https://github.com/blolol/hector-identity-blolol'
  s.summary = 'Blolol identity adapter for Hector'
  s.description = 'An identity adapter that talks to the Blolol authentication API.'
  s.files = Dir['lib/hector/*.rb']
  s.require_path = 'lib'

  s.add_dependency 'em-http-request', '>= 1.1.2'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'webmock', '~> 1.18.0'
end
