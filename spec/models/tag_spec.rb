require 'spec_helper'

describe Tag do
	it { should validate_presence_of :word }
	it { should validate_uniqueness_of :word }
	it { should have_and_belong_to_many :stories }
end
