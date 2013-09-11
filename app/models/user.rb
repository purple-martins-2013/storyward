class User < ActiveRecord::Base

  has_many :stars
  has_many :stories
  has_many :starred_stories, through: :stars, source: :story
  has_many :nodes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  def favorite_authors
    self.starred_stories.map{|s| s.user}
  end

  def self.find_or_create_from_oauth(auth)
    if auth.provider == 'twitter'
      find_for_twitter_oauth(auth)
    elsif auth.provider == 'facebook'
      find_for_facebook_oauth(auth)
    end
  end

  def self.find_for_facebook_oauth(auth)
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

  def self.find_for_twitter_oauth(auth)
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
end
