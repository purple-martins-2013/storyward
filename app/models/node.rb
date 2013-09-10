class Node < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :content

  belongs_to :user
  has_many :stories, :inverse_of => :node

  before_save :sanitize_content

  def sanitize_content
    self.content = Sanitize.clean(self.content, Sanitize::Config::RESTRICTED)
  end
end
