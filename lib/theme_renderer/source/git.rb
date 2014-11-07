# -*- encoding : utf-8 -*-
require 'rugged'
#
# /assets
#   ...
# /config
#   /locale
# /views
#   ...
#
module ThemeRenderer
  module Source
    # @example
    #   walker = Git.new
    #   walker.walk do |item,path|
    #     puts path
    #     puts "-"*10
    #     puts item
    #   end
    class Git
      attr_accessor :repo, :master

      def initialize(path = './')
        @repo = Rugged::Repository.new(path)
        @master = repo.branches['master']
      end

      def walk(items = nil, path = './', &block)
        items ||= master.target.tree

        items.each do |item|
          if item[:type] == :blob
            block.call read_content(item), path, item[:name]
          elsif item[:type] == :tree
            sub_items = repo.lookup(item[:oid])
            walk(sub_items, File.join(path, item[:name]), &block)
          end
        end
      end

      def branch_sha(branch_name = 'master')
        repo.branches[branch_name].target_id
      end

      def read_content(blob)
        repo.lookup(blob[:oid]).content
      end
    end
  end
end
