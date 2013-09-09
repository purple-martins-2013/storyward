class Star < ActiveRecord::Base
	validates_uniqueness_of :story_id, :scope => :user_id
  belongs_to :user
  belongs_to :story
end
