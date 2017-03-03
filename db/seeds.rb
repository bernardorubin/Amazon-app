# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  User.create(first_name: Faker::Pokemon.name, last_name: Faker::Pokemon.name, email: Faker::Internet.email, password_digest: Faker::Internet.password)
end


5.times do
  Category.create(name: Faker::Pokemon.name)
end


100.times do
  Product.create(title: Faker::Pokemon.name, description: Faker::LordOfTheRings.location, price: Faker::Number.decimal(2), category: Category.last.id, user_id: User.last.id)
end

10.times do
  Tag.create name: Faker::Hipster.word
end
