class Article < ActiveRecord::Base
  acts_as_commentable

  validates_presence_of :title, :content

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  def tag_names=(names)
    self.tags = Tag.with_names names.split
  end

  def tag_names
    tags.map(&:name).join(' ')
  end
end
