module ThemeRenderer
  module ThemeStorage
    module CoreMethods
      def get_templates(conditions = {})
        templates(conditions)
      end
    end

    class Base
      include ThemeRenderer::ThemeStorage::CoreMethods
    end
  end
end
