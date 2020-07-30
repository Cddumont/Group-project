require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name { 'John' }
    last_name { 'Jones' }
    sequence(:username) { |n| "username#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'member' }

    trait :admin do 
      role { 'admin' }
    end
  end
end
