require 'buff/config/json'

module ThemeRenderer
  class Config < Buff::Config::JSON
    class << self
      def validate!(config)
        fail InvalidConfig, config.errors unless config.valid?
      end
    end

    attribute 'theme.stores',
              default: ['TR::ThemeStorage::File'],
              type: Array,
              coerce: Proc do |m|
                Array(m).collect do |store|
                  "TR::ThemeStorage::#{store}"
                end
              end

    attribute 'theme.valid_activation_modes',
              default: [:prepend, :overwrite, :append]

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

    attribute 'themeable_current_method_name',
              default: 'current_theme',
              type: String

    attribute 'parent_engine',
              default: ::Rails.application,
              type: Class

    attribute 'theme.activation_method',
              default: :prepend

    def activation_method
      if theme.valid_activation_modes.include?(theme.activation_method)
        theme.activation_method
      else
        :prepend
      end
    end

    def validate!
      self.class.validate!(self)
    end

    def configure
      yield self
    end
  end
end
