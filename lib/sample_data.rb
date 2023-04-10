require "faker"

def generate_sample_data
  35.times do
    category = Faker::Commerce.department(max: 2, fixed_amount: true)
    name = Faker::Commerce.product_name
    purchase_date = Faker::Date.between(from: 2.years.ago, to: Date.today)
    expiration_date = Faker::Date.between(from: purchase_date, to: purchase_date + 1.year)
    quantity = Faker::Number.between(from: 1, to: 10)
    description = Faker::Lorem.sentence
    img = Faker::LoremPixel.image(size: "300x300", is_gray: false, category: 'technics')
    location = Faker::Address.full_address

    Item.create!(
      category: category,
      name: name,
      purchase_date: purchase_date,
      expiration_date: expiration_date,
      quantity: quantity,
      description: description,
      img: img,
      location: location
    )
  end
end
