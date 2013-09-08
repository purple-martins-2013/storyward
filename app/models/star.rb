class Star < ActiveRecord::Base
	validates_uniqueness_of :story_id, :scope => :user_id
end
