class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  has_and_belongs_to_many :tags

  validates :title, :user, presence: true

end
