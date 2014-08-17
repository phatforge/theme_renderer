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

    attribute 'theme.activation_method',
      default: :prepend,
      type: Symbol

    attribute 'storage.file.theme_root',
      default: 'themes',
      type: String

    attribute 'theme_id',
      default: 'default',
      type: String

    attribute 'themeable_class',
      default: 'site',
      type: String

    attribute 'themeable_attribute',
      default: 'theme_id',
      type: String

    attribute 'themeable_settings_attribute',
      default: 'theme_settings',
      type: String

    attribute 'parent_engine',
      default: ::Rails.application,
      type: Class

    attribute 'theme_transform',
      default: nil,
      type: Proc

    def validate!
      self.class.validate!(self)
    end

    def configure
      yield self
    end
  end
end
