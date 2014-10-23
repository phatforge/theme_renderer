module ThemeRenderer
  class Publisher
    attr_accessor :theme

    def initialize(theme)
      @theme = theme
    end

    def call
      return false unless theme.repository_uri
      # Fetch latest source
      TR::Source::Git.new(theme.repository_uri.path).walk do |content, path_key, item|
        puts item
      end
      # Process source:
      #     Upload assets
      #     Store locales

      # @config.processors.each {|p| p.call(update) }
      #
      #     (Settings?)
      #
      # Store in redis
      # @config.cache_storage.store(update)
      #
      # Success: Bump version
      # Fail: rollback (flush redis, rm assets, cleanup tmp files)
      #
      # Inform user
    end
  end
end
