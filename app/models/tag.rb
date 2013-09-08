class Tag < ActiveRecord::Base
	validates_presence_of :word
	validates_uniqueness_of :word

	has_and_belongs_to_many :stories
end
