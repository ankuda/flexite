$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'flexite/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'flexite'
  s.version     = Flexite::VERSION
  s.authors     = ['Maksim Rusakovich']
  s.email       = ['rusakovich.maksim@gmail.com']
  s.homepage    = 'https://github.com/mrusakovich/flexite'
  s.summary     = 'Database driven web-app settings'
  s.description = 'Database driven web-app settings'

  s.files = Dir["{app,config,db,lib}/**/*"] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir["test/**/*"]
  s.required_ruby_version = '~> 2.3.0'

  s.add_dependency 'delayed_job_active_record', '~> 4.0.3'
  s.add_dependency 'daemons', '~> 1.2.0'

  s.add_runtime_dependency 'rails', '~> 3.2', '>= 3.2.22'
  s.add_runtime_dependency 'simple_form', '~> 2.1', '>= 2.1.3'
  s.add_runtime_dependency 'hashie', '~> 3.4', '>= 3.4.6'
  s.add_runtime_dependency 'haml-rails', '~> 0.4.0'
  s.add_runtime_dependency 'hashdiff', '~> 0.3.7'
  s.add_runtime_dependency 'deep_cloneable', '~> 2.4.0' 

  s.add_development_dependency 'haml-rails', '~> 0.4.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'syck', '~> 1.3', '>= 1.3.0'
end
