require 'action_view/template'
module ThemeRenderer
  module ThemeStorage
    class Redis < Base
      DEFAULT_PATTERN = ":prefix/:action{.:locale,}{.:formats,}{.:handlers,}"

      attr_accessor :config, :theme_root, :theme_path

      def initialize(config, pattern = nil)
        # config.validate!
        @pattern = pattern || DEFAULT_PATTERN
        @config = config
        @theme_path = resolve_theme_path
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

      def find_templates(name, prefix, partial, details)
        path = ::ActionView::Resolver::Path.build(name, prefix, partial)
        query(path, details, details[:formats])
      end

      def build_query(path)
        [theme_root, config.theme_id, 'views', path, '*'].join('/')
      end

      def query(path, details, formats)
        pattern = build_query(path)
        handler, format = extract_handler_and_format(template, formats)

        redis = ::Redis.new(db: 5)
        keys = redis.scan_each(match: pattern)
        keys.collect do |k|
          { contents: redis.get(k),
            idenitifier: k,
            handler: handler,
            details: details
          }
        end
      end

      def extract_handler_and_format(path, default_formats)
        pieces = File.basename(path).split(".")
        pieces.shift
        handler = Template.handler_for_extension(pieces.pop)
        format  = pieces.last && Mime[pieces.last]
        [handler, format]
      end

      # def escape_entry(entry)
      #   entry.gsub(/[*?{}\[\]]/, '\\\\\\&')
      # end

      # def resolve_theme_path
      #   theme_id = normalize_theme_id(config.theme_id)
      #   @theme_path ||= [theme_root, theme_id].join('/')
      # end

      # def normalize_theme_id(theme_id)
      #   theme_id << '/views'
      # end

      # def theme_root
      #   @theme_root ||= '/themes'
      # end

      #/themes/<sha>/views/<path(.en.html.haml)>
    end
  end
end