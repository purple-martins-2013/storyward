class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  has_and_belongs_to_many :tags

  has_many :stars
  has_many :users, through: :stars

  validates :title, :user, presence: true

  accepts_nested_attributes_for :node

  acts_as_taggable

  def bookmarked?(user)
		Star.where(user_id: user.id, story_id: self.id).any?
  end
end
