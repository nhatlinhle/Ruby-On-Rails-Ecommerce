# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faker'

puts "🌱 Seeding started..."

User.delete_all
100.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "123456",
    password_confirmation: "123456",
    avatar: Faker::Avatar.image,
    address: Faker::Address.full_address,
    birth_day: Faker::Date.birthday(min_age: 18, max_age: 65).strftime("%Y-%m-%d"),
    phone_number: Faker::PhoneNumber.cell_phone_in_e164
  )
end

load Rails.root.join('db', 'seeds', 'categories.rb')
load Rails.root.join('db', 'seeds', 'products.rb')

puts "✅ Seeding done!"
