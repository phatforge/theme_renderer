module ThemeRenderer
  class Engine < ::Rails::Engine
    isolate_namespace ThemeRenderer

    initializer 'insert ThemeRenderer::TemplateResolver' do |app|
    end
  end
end
