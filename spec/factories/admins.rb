FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
  end
end
