require 'spec_helper'

describe Star do
	it { should validate_uniqueness_of(:story_id).scoped_to(:user_id) }
end
