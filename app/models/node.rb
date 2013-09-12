class Node < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content

  belongs_to :user
  has_many :stories, :inverse_of => :node

  before_create :build_parent_path
  before_save :sanitize_content

  def as_hash
  	{ id: self.id, title: self.title, content: self.content, author: self.user.name }
  end

  def parent_chain
    find_ordered_from_array(self.parent_path)
  end

  def children_objects
    find_ordered_from_array(self.children_nodes)
  end

  private
  def sanitize_content
    self.content = Sanitize.clean(self.content, Sanitize::Config::RESTRICTED)
  end

  def build_parent_path
    unless self.parent_node == 0
      self.parent_path = self.class.find(parent_node).parent_path
      self.parent_path.push(parent_node)
      self.parent_path_will_change!
    end
  end

  def find_ordered_from_array(ids_array)
  	unordered_nodes = self.class.find(ids_array)
    objects.map{|id| unordered_nodes.detect{|each| each.id == id}}  
  end
end
