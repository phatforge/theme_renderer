module ThemeRenderer
  module ThemeStorage
    class File < ::ActionView::OptimizedFileSystemResolver
      include ThemeRenderer::ThemeStorage::CoreMethods

      attr_accessor :config, :theme_root, :theme_path

      def initialize(config, pattern = nil)
        config.validate!
        @config = config
        @theme_path = resolve_theme_path
        super(theme_path, pattern)
      end

      def initialize_template(record)
        record
      end

      private

      def records(conditions = {})
        find_templates(conditions[:name],
                       conditions[:prefix],
                       conditions[:partial],
                       conditions[:details]
                      )
      end

      def resolve_theme_path
        # puts config.inspect
        # puts @theme_path
        theme_id = normalize_theme_id(config.theme_id)
        @theme_path ||= [::Rails.root, theme_root, theme_id].join('/')
      end

      def normalize_theme_id(theme_id)
        theme_id << '/views' unless theme_id.include?('/')
      end

      def theme_root
        klass_name = self.class.name.demodulize.downcase
        @theme_root ||= config.storage.send(klass_name).theme_root
      end
    end
  end
end
