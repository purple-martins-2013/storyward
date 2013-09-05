class Node < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :parent_node

  belongs_to :user
  has_and_belongs_to_many :stories
end
