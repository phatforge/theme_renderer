require 'redis'
require 'action_view/template'

module ThemeRenderer
  module ThemeStorage
    class Redis < Base
      # rubocop:disable Style/StringLiterals
      DEFAULT_PATTERN = ":prefix/:action{.:locale,}{.:formats,}{.:handlers,}"
      # rubocop:enable Style/StringLiterals

      attr_accessor :config, :theme_root, :theme_path, :path

      def initialize(config, pattern = nil)
        config.validate!
        @pattern = pattern || DEFAULT_PATTERN
        @config = config
      end

      def initialize_template(record, details, conditions)
        handler = ::ActionView::Template.registered_template_handler(record.handler)

        contents = record.source
        identifier = "#{self.class} - #{record.key}"

        details[:format] = Mime[record.format]
        details[:virtual_path] = virtual_path(record.path, record.partial)
        details[:updated_at] = Time.parse(record.updated_at)
        # details[:virtual_path] = record

        ActionView::Template.new(
          contents,
          identifier,
          handler,
          details
        )
      end

      private

      def templates(conditions = {})
        records(conditions).collect do |record|
          initialize_template(record, conditions[:details], conditions)
        end
      end

      def records(conditions = {})
        # resolve virtual_path
        # resolve key_pattern / default_pattern
        # redis_data(key_pattern)
        #
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
        key_pattern = build_query(path)
        redis_data(key_pattern)
      end

      def build_query(path)
        [theme_root, config.theme_id, 'views', path ].join('/') << '*'
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
        data_set = []
        redis.scan_each(match: pattern) do |key|
          data = redis.hgetall(key)
          data.merge!(key: key)
          data_set << OpenStruct.new(data)
        end
        data_set
      end

      def normalize_path(name, prefix)
        [prefix, name].compact.join('/')
      end

      def virtual_path(path, partial)
        return path unless partial
        if index = path.rindex('/')
          path.insert(index + 1, '_')
        else
          "_#{path}"
        end
      end

      def redis
        ::Redis.new(db: 5)
      end
    end
  end
end
