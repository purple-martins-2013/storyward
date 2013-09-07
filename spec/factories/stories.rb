FactoryGirl.define do
	factory :story do
		title 'Story Title'
    sequence(:tail_node) {|n| "#{n}"}
    user
	end
end
