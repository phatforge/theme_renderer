# -*- encoding : utf-8 -*-
module ThemeRenderer
  class Publisher
    attr_accessor :theme
    attr_reader :sha

    def initialize(theme)
      @theme = theme
    end

    def call
      return false unless theme.repository_uri
      # Fetch latest source
      TR::Source::Git.new(theme.repository_uri.path).walk do |content, path_key, item|
        # puts item
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
      @sha = TR::Source::Git.new(theme.repository_uri.path).branch_sha
      # Fail: rollback (flush redis, rm assets, cleanup tmp files)
      #
      # Inform user
      nil
    end
  end
end
