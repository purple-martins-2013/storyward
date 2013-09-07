require 'faker'

FactoryGirl.define do
  factory :node do |f|
    f.title { Faker::Lorem.sentence(4) }
    f.content { Faker::Lorem.paragraphs(3).join(" ") }
    sequence(:parent_node) {|n| n }
    user
  end
end
