module ThemeRenderer
  module ThemeStorage
    module CoreMethods
      def get(conditions={})
        templates = records(conditions).flatten.collect do |record|
          initialize_template(record)
        end
      end

      private

        def initialize_template(record)
          ActionView::Template.new(record.contents,
                                   record.identifier,
                                   record.handler,
                                   record.details)
        end
    end

    class Base
      include ThemeRenderer::ThemeStorage::CoreMethods
    end
  end
end
