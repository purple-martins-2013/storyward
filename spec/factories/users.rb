FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    name "Test User"
    password "password"
    password_confirmation "password"
  end
end
