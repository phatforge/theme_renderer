# -*- encoding : utf-8 -*-
module ThemeRenderer
  class Theme
    attr_accessor :version, :name, :repository_uri

    def initialize(name, repository_uri=nil)
      @name = name
      @repository_uri = repository_uri
    end

    def publish!
      ThemeRenderer::Publisher.new(self).publish!
      next_version = version.try(:next) || Version.new
      version = next_version.save
    end

    def version_number
      version.number if version
    end

    class Version < ActiveRecord::Base
      self.table_name = 'theme_versions'

      attr_accessor :number

      def next
        Version.new
      end

    end
  end
end