require 'theme_renderer/errors'

module ThemeRenderer
  autoload :Config, 'theme_renderer/config'
  autoload :ThemeStorage, 'theme_renderer/theme_storage'
  module ThemeStorage
    autoload :File, 'theme_renderer/theme_storage/file'
  end
  autoload :ThemeResolver, 'theme_renderer/theme_resolver'
end

# alias for ThemeRenderer
TR = ThemeRenderer

module ThemeRenderer
  require "theme_renderer/engine" if defined?(Rails)
end
