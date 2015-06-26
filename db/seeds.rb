require 'csv'



def create_product(amount=10)
  images = %w(http://i.imgur.com/bwy74ok.jpg
  http://i.imgur.com/bAZWoqx.jpg
  http://i.imgur.com/PgmEBSB.jpg
  http://i.imgur.com/aboaFoB.jpg
  http://i.imgur.com/LkmcILl.jpg
  http://i.imgur.com/q9zO6tw.jpg
  http://i.imgur.com/r8p3Xgq.jpg
  http://i.imgur.com/hODreXI.jpg
  http://i.imgur.com/UORFJ3w.jpg)
  amount.times do
    Product.create(
      name: Faker::App.name,
      price: Faker::Commerce.price.round(2),
      quantities: rand(10)+1,
      photo_url: images.sample
      )
  end
end

if Product.count <= 10
  create_product
else
  create_product((10-Product.count))
end

CSV.foreach(Rails.root.join('db/seed_data', 'states.csv'), {headers: true, header_converters: :symbol}) do |row|
  State.find_or_create_by(row.to_hash)
end