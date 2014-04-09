$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require "theme_renderer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'theme_renderer'
  s.version     = ThemeRenderer::VERSION
  s.authors     = ['Pritesh Mehta']
  s.email       = ['pritesh@phatforge.com']
  s.homepage    = 'https://github.com/phatforge/theme_renderer'
  s.summary     = 'Theme renderer to better scale in whitelabel solutions'
  s.description = 'Theme renderer for white label solution. This component will render from alternate theme stores'

  s.files = Dir["{app,config,db,lib}/**/*"] + ['LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2.17'
  s.add_dependency 'tilt'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rails_best_practices'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'guard-rails_best_practices'
  s.add_development_dependency 'guard-brakeman'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'minitest', '~> 4.7.5'
  s.add_development_dependency 'mark'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-remote'
  s.add_development_dependency 'pry-nav'
end
