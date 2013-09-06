class Story < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :nodes

  validates :title, :user, presence: true

end
