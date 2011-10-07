class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :articles, :through => :taggings

  def self.with_names(names)
    names.map do |name|
      Tag.find_or_create_by_name(name.downcase)
    end
  end
end
