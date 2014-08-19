module ThemeRenderer
  class ThemeResolver < ::ActionView::Resolver
    attr_reader :config

    def initialize(config = Config.new)
      config.validate!
      @config = config
      super()
    end

    def find_templates(name, prefix, partial, details)
      conditions = {
        name: name, prefix: prefix,
        path: normalize_path(name, prefix),
        locale: normalize_array(details[:locale]).first,
        formats: normalize_array(details[:formats]).first,
        handlers: normalize_array(details[:handlers]),
        details: details, partial: partial || false
      }

      templates_from_storage(conditions)
    end

    private

    def templates_from_storage(conditions)
      stores.collect do |store|
        store_instance(store).get(conditions)
      end.flatten
    end

    def stores
      config.theme.stores
    end

    def store_instance(store)
      store.constantize.new(config)
    end

    def normalize_array(array)
      array.map(&:to_s)
    end

    def normalize_path(name, prefix)
      [prefix, name].compact.join('/')
    end
  end
end
