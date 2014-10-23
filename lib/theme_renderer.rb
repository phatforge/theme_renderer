require 'theme_renderer/errors'

module ThemeRenderer
  autoload :Config, 'theme_renderer/config'
  autoload :ThemeStorage, 'theme_renderer/theme_storage'
  module ThemeStorage
    autoload :File, 'theme_renderer/theme_storage/file'
    autoload :Redis, 'theme_renderer/theme_storage/redis'
  end
  module Source
    autoload :Git, 'theme_renderer/source/git'
  end
  autoload :ThemeResolver, 'theme_renderer/theme_resolver'
  autoload :Publisher, 'theme_renderer/publisher'
end

# alias for ThemeRenderer
TR = ThemeRenderer

module ThemeRenderer
  require 'theme_renderer/engine' if defined?(Rails)
end
