class User < ActiveRecord::Base

  has_many :stars
  has_many :stories, through: :stars
  has_many :nodes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]
  

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           image_url: auth.info.image.gsub("square", "large")
                           )
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create!(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email || "#{auth.provider}-#{auth.uid}@storyward.com",
                           password:Devise.friendly_token[0,20],
                           image_url: auth.info.image.gsub('_normal','')
                           )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      case user.provider
      when 'facebook'
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      when 'twitter'
        if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      else
      end
    end
  end

end
