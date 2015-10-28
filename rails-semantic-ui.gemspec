$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rails/semantic_ui/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails-semantic-ui'
  s.version     = Rails::SemanticUI::VERSION
  s.authors     = ['Jeong, Jiung']
  s.email       = ['ethernuiel@sanultari.com']
  s.homepage    = 'https://github.com/astral1/rails-semantic-ui'
  s.summary     = 'Rails plugin for using semantic-ui with rails-webpack'
  s.description = 'Rails plugin for using semantic-ui with rails-webpack'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.4'
  s.add_dependency 'rails-webpack', '~> 0.3', '>= 0.3.1'
end
