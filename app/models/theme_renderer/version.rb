# require 'active_record'
class Version # < ::ActiveRecord::Base
#  self.table_name = 'theme_versions'

  attr_accessor :number, :sha

  def initialize(theme, sha)
    @sha = sha
    @number = (theme.version_number || 0) + 1
  end

  def next
    Version.new
  end
end
