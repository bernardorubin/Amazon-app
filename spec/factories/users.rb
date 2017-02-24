FactoryGirl.define do
  factory :user do
    first_name { Faker::Pokemon.name }
    last_name { Faker::Pokemon.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
  end
end
