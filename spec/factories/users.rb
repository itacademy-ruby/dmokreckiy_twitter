require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@test.com" }
    sequence(:login) {|n| "test_login#{n}" }
    password 'password'
  end
end