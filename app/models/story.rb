class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  has_and_belongs_to_many :tags

  has_many :stars
  has_many :users, through: :stars
  attr_reader :tag_tokens

  validates :title, :user, presence: true

  accepts_nested_attributes_for :node

  acts_as_taggable

end
