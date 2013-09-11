class Node < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content

  belongs_to :user
  has_many :stories, :inverse_of => :node

  before_save :sanitize_content

  def sanitize_content
    self.content = Sanitize.clean(self.content, Sanitize::Config::RESTRICTED)
  end

  def as_hash
  	{ id: self.id, title: self.title, content: self.content, author: self.user.name }
  end

  #TODO - this is really, really, incredibly expensive. Refactor when time allows! 
  def parent_chain
  	parent_nodes = []
  	node = self
  	while node.parent_node != 0
  		parent = self.class.find(node.parent_node)
  		parent_nodes << parent
  		node = parent
  	end
  	parent_nodes.reverse
  end

  def children_objects
  	self.children_nodes.map{|id| self.class.find(id)}
  end

end
