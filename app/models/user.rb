class User < ActiveRecord::Base
  validates_presence_of :service_id

  devise :database_authenticatable, :trackable, :omniauthable

  has_many :comments

  def admin?
    false
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_service_id(data["id"].to_s)
      user
    else # Create a user with a stub password.
      User.create(
          :service_id => data["id"].to_s,
          :service_type => "facebook",
          :password => Devise.friendly_token[0,20],
          :name => data["name"],
          :link => data["link"]
      )
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_service_id(data["id"].to_s)
      user
    else # Create a user with a stub password.
      User.create(
          :service_id => data["id"].to_s,
          :service_type => "twitter",
          :password => Devise.friendly_token[0,20],
          :name => data["name"] || data["screen_name"],
          :link => data["url"] || "http://twitter.com/#{ data["screen_name"] }"
      )
    end
  end
end
