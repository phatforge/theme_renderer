require 'buff/config/json'
require 'theme_renderer/errors'

module ThemeRenderer
  module Storage
    class File #< OpenStruct.new(config: Hash.new)
      def initialize
        @config = { path: '/tmp/' }
      end
    end
    class Redis #< OpenStruct.new(config: Hash.new)
      def initialize
        @config = { host: 'localhot', port: 6379, uri: 'redis://localhost:6379/theme_renderer/5', namespace: 'theme_renderer', db: 5, password: nil, pool: nil}
      end
    end
  end
  class Config < Buff::Config::JSON
    class << self

      def validate!(config)
        unless config.valid?
          raise InvalidConfig.new(config.errors)
        end
      end

    end

    attribute 'theme.storage',
      default: TR::Storage::File,
      type: String,
      required: true,
      coerce: lambda { |m|
        "TR::Storage::#{m}".constantize
      }

    def validate!
      self.class.validate!(self)
    end

    attr_reader :storage

    DEFAULT_THEME_STORAGE = ::ThemeRenderer::Storage::File

    def initialize(args={})
      @insertion_point = args.fetch('insert', :before)
      @storage = args.fetch('storage', default_theme_storage)

    end

    def default_theme_storage
      DEFAULT_THEME_STORAGE
    end

    VALID_INSERTION_POINTS = [:after, :before]

    def valid?
      true
    end
  end
end
