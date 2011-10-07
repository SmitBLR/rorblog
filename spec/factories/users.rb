FactoryGirl.define do
  factory :user do
    service_id 123456789
    service_type "facebook"
    name "John Connor"
    link "http://facebook.com/JohnConnor"
    password 'password'
  end
end
