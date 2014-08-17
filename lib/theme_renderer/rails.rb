module ThemeRenderer
  module Rails
    # nodoc
    module AttributeResolver
      def self.included(base)
        base.send :include, ThemeRenderer::Rails::AttributeResolver::InstanceMethods
        base.send :before_filter, :set_theme_resolver
      end

      # Instance Methods to be included into ApplicationController instances
      module InstanceMethods
        # setup resolver cache
        @@theme_resolver = {}

        # set_theme_resolver_for_current_request
        def set_theme_resolver(themeable_instance = current_themeable_instance)
          return unless themeable_instance
          resolver = theme_resolver_for(themeable_instance)
          activate_theme(resolver)
        end

        def activate_theme(resolver)
          case resolver.config.theme.activation_method
          when :prepend
            prepend_view_path resolver
          when :overwrite
            self.view_paths = resolver
          end
        end

        # retrieve theme resolver for current instance of themeable class
        def theme_resolver_for(themeable)
          @@theme_resolver[themeable.id] ||= load_theme_resolver(themeable)
        end

        def current_themeable_instance
          current_themeable_instance = Object.const_get(theme_class.camelize.singularize).
            find_by_id(params[:"#{theme_class}_id"])
        end

        def theme_class
          theme_config.themeable_class
        end

        def theme_id_attribute
          theme_config.themeable_attribute
        end

        def theme_settings_attribute
          theme_config.themeable_settings_attribute
        end

        def theme_finder
          "find_by_#{theme_id_attribute}".to_sym
        end

        def theme_config
          ::Rails.application.config.theme_renderer
        end

        def load_theme_resolver(themeable_instance)
          theme_id = themeable_instance.send(theme_id_attribute)
          if themeable_instance.respond_to?(theme_settings_attribute)
            theme_settings = themeable_instance.send(theme_settings_attribute)
          else
            theme_settings = {}
          end
          ThemeResolver.new(resolver_config(theme_id, theme_settings))
        end

        def resolver_config(theme_id, theme_settings)
          new_config = ThemeRenderer::Config.new
          new_config.theme_id = theme_id
          theme_settings.each_pair do |k, v|
            new_config.send :"#{k}=", v
          end
          new_config
        end
      end
    end
  end
end
