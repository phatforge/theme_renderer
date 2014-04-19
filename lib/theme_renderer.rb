require "theme_renderer/engine"

module ThemeRenderer
  autoload :Config, 'theme_renderer/config'
  autoload :ThemeStore, 'theme_renderer/theme_store'
  autoload :ThemeResolver, 'theme_renderer/theme_resolver'
end

# alias for ThemeRenderer
TR = ThemeRenderer
