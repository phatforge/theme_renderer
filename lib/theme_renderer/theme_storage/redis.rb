require 'redis'
require 'action_view/template'

module ThemeRenderer
  module ThemeStorage
    class Redis < Base
      # rubocop:disable Style/StringLiterals
      DEFAULT_PATTERN = "/%{theme_prefix}/%{prefix}/%{action}.%{locale}.%{formats}.%{handler}"
      # rubocop:enable Style/StringLiterals

      attr_accessor :config, :theme_root, :theme_path, :path, :pattern

      def initialize(config, pattern = nil)
        config.validate!
        @pattern = pattern || DEFAULT_PATTERN
        @config = config
      end

      def initialize_template(record)
        ::ActionView::Template.new(
          record.source,                   # template source
          "#{self.class} - #{record.key}", # template identifier
          handler_for(record.handler),     # template handler
          details_hash_for(record)         # template details
        )
      end

      private

      def templates(conditions = {})
        records(conditions).collect do |record|
          initialize_template(record)
        end
      end

      def records(conditions = {})
        interpolate_pattern(conditions)
        redis_records(pattern)
      end

      def interpolate_pattern(dict)
        dict[:theme_prefix] = theme_prefix
        dict[:action] = virtual_path(dict[:name], dict[:partial])
        dict[:handler] = dict[:handlers].first
        @pattern = pattern % dict
      end

      def theme_prefix
        [
        theme_identifier,
        'views'
        ].join('/')
      end

      def theme_identifier
        config.theme.sha || config.theme_id
      end

      def handler_for(handler_name)
        ::ActionView::Template.registered_template_handler(handler_name)
      end

      def mime_for(format)
        Mime[format]
      end

      def details_hash_for(record)
        {
          virtual_path: virtual_path(record.path, record.partial),
          format: mime_for(record.format.to_sym),
          updated_at: Time.at(record.updated_at.to_i)
        }
      end

      def redis_records(pattern)
        redis.scan_each(match: pattern).collect do |key|
          data = redis.hgetall(key)
          data.merge!(key: key)
          OpenStruct.new(data)
        end
      end

      def virtual_path(path, partial)
        return path unless partial
        index = path.rindex('/')
        if index
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
