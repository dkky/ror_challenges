class User < ActiveRecord::Base
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  attr_accessor :password_confirmation
  
   has_many :listings, :dependent => :destroy
   has_many :authentications, :dependent => :destroy
   has_many :reservations, :dependent => :destroy

  def name
    "#{first_name} #{last_name || ''}"
  end

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end
