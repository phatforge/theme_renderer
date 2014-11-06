# -*- encoding : utf-8 -*-

module ThemeRenderer
  class Theme
    attr_accessor :version, :name, :repository_uri

    def initialize(name, repository_uri = nil)
      @name = name
      @repository_uri = repository_uri
    end

    def publish!
      publisher = ThemeRenderer::Publisher.new(self)
      publisher.call
      # bump_version
      @version = Version.new(self, publisher.sha)
      @version.inspect
    end

    def version_sha
      version.sha if version
    end

    def version_number
      version.number if version
    end
  end
end
