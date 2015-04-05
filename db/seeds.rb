def create_product(amount=10)
  amount.times do
    Product.create(
      name: Faker::App.name,
      price: Faker::Commerce.price.round(2),
      quantities: rand(10)+1
      )
  end
end

if Product.count <= 10
  create_product
else
  create_product((10-Product.count))
end