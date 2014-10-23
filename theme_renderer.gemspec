$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'theme_renderer/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'theme_renderer'
  s.version     = ThemeRenderer::VERSION
  s.authors     = ['Pritesh Mehta']
  s.email       = ['pritesh@phatforge.com']
  s.homepage    = 'https://github.com/phatforge/theme_renderer'
  s.summary     = 'Theme renderer to better scale in whitelabel solutions'
  s.description = <<-DESC
  Theme renderer for white label solution.
  This component will render from alternate theme stores
  DESC

  s.files       = Dir['{app,config,db,lib}/**/*']
  s.files       += ['LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files  = Dir['{test,spec}/**/*']

  s.add_runtime_dependency 'buff-config'
  s.add_runtime_dependency 'rails', '~> 3.2.17'
  s.add_runtime_dependency 'tilt'
  s.add_runtime_dependency 'rugged'
  s.add_runtime_dependency 'redis'

  s.add_development_dependency 'rails_best_practices'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'guard-rails_best_practices'
  s.add_development_dependency 'guard-brakeman'
  s.add_development_dependency 'guard-rubycritic'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'minitest', '~> 4.7.5'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara_minitest_spec'
  s.add_development_dependency 'mark'
  s.add_development_dependency 'pry'
end
