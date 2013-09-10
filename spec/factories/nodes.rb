require 'faker'

FactoryGirl.define do
  factory :node do |f|
    f.title { Faker::Lorem.sentence(4) }
    f.content { Faker::Lorem.paragraphs(3).join(" ") }
    user
    f.parent_node 0
  end
end
