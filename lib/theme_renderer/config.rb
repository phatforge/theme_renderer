require 'buff/config/json'

module ThemeRenderer
  class Config < Buff::Config::JSON
    class << self

      def validate!(config)
        unless config.valid?
          raise InvalidConfig.new(config.errors)
        end
      end

    end

    attribute 'theme.stores',
      default: ['TR::ThemeStorage::File'],
      type: Array,
      coerce: lambda { |m|
        puts m.inspect
        Array(m).collect do |store|
          "TR::ThemeStorage::#{store.to_s}"
        end
      }

    attribute 'storage.file.theme_root',
      default: 'themes',
      type: String

    attribute 'theme_id',
      default: 'default',
      type: String

    def validate!
      self.class.validate!(self)
    end

    def configure
      yield self
    end
  end
end
