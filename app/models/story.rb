class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :node

  validates :title, :user, presence: true

end
