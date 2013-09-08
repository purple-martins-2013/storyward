class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :node

  has_many :stars
  has_many :users, through: :stars

  validates :title, :user, presence: true

end
