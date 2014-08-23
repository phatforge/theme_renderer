class Post < ActiveRecord::Base
  belongs_to :site
  attr_accessible :body, :slug, :title
end
