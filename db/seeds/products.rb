puts "Creating products with Faker..."

category_ids = Category.pluck(:id)

Product.delete_all

100.times do |i|
  Product.create!(
    name: Faker::Commerce.product_name,
    slug: Faker::Internet.slug,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    price: Faker::Commerce.price(range: 100.0..1000.0),
    sku: Faker::Alphanumeric.alphanumeric(number: 8).upcase,
    stock_quantity: rand(1..50),
    category_id: category_ids.sample
  )
end

puts "✅ Products seeded with Faker!"
