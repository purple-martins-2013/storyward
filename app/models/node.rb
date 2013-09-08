class Node < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content

  belongs_to :user
  has_many :stories, :inverse_of => :node
end
