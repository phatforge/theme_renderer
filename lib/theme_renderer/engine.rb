module ThemeRenderer
  autoload :Config, 'theme_renderer/config'
  autoload :Rails, 'theme_renderer/rails'

  class Engine < ::Rails::Engine
    isolate_namespace ThemeRenderer

    config.theme_renderer = ThemeRenderer::Config.new

    initializer "Set up default parent engine" do |app|
      config.theme_renderer.parent_engine ||= ::Rails.application
    end

    initializer 'theme_renderer.action_controller_hook' do
      ActiveSupport.on_load(:action_controller) do
        include ThemeRenderer::Rails::AttributeResolver
      end
    end
  end
end
