require 'redis'
require 'action_view/template'

module ThemeRenderer
  module ThemeStorage
    class Redis < Base
      # rubocop:disable Style/StringLiterals
      DEFAULT_PATTERN = ":prefix/:action{.:locale,}{.:formats,}{.:handlers,}"
      # rubocop:enable Style/StringLiterals

      attr_accessor :config, :theme_root, :theme_path

      def initialize(config, pattern = nil)
        config.validate!
        @pattern = pattern || DEFAULT_PATTERN
        @config = config
      end

      def initialize_template(record, details, handler, format)
        contents = redis.get(record)
        details[:format] = format

        ActionView::Template.new(
          contents,
          record,
          handler,
          details
        )
      end

      private

      def templates(conditions = {})
        formats = conditions[:formats]

        records(conditions).collect do |record|
          handler, format = extract_handler_and_format(record, formats)
          initialize_template(record, conditions[:details], handler, format)
        end
      end

      def records(conditions = {})
        query_storage(conditions[:name],
                      conditions[:prefix],
                      conditions[:partial],
                      conditions[:details]
                     )
      end

      def query_storage(name, prefix, partial, details)
        path = ::ActionView::Resolver::Path.build(name, prefix, partial)
        query(path, details, details[:formats])
      end

      def query(path, _details, _formats)
        pattern = build_query(path)
        redis_data(pattern)
      end

      def build_query(path)
        [theme_root, config.theme_id, 'views', path, '*'].join('/')
      end

      def extract_handler_and_format(path, default_formats)
        pieces = ::File.basename(path).split('.')
        pieces.shift
        handler = ActionView::Template.handler_for_extension(pieces.pop)
        format  = pieces.last && Mime[pieces.last]
        format ||= default_formats
        [handler, format]
      end

      def redis_data(pattern)
        redis.scan_each(match: pattern)
      end

      def redis
        ::Redis.new(db: 5)
      end
    end
  end
end