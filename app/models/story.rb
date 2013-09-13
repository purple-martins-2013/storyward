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

  def find_parent
    recurse_parent(self.node)
  end

  def recurse_parent(node)
    return node if node.parent_node == 0
    return recurse_parent(Node.find(node.parent_node))
  end

	def bookmarked?(user)
  	Star.where(user_id: user.id, story_id: self.id).any?
	end

end
