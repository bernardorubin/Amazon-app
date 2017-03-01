FactoryGirl.define do
  factory :product do
    # association :user, factory: :user
    user

    title { Faker::RockBand.name }
    description { Faker::Hipster.sentence }
    price { Faker::Number.decimal(2) }
  end
end
