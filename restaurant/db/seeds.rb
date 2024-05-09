# indian_states = [
#   "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
#   "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Maharashtra",
# ]

# indian_cities = [
#   "Vijayawada",
#   "Naharlagun",
#   "Silchar",
#   "Gaya",
#   "Bhilai",
#   "Vasco da Gama",
#   "Surat",
#   "Gurgaon",
#   "Dharamshala",
#   "Pune",
# ]

require "faker"

# 10.times do |i|
#   State.create(
#     name: indian_states[i += 1],
#   )
# end
# 11.times do |j|
#   j += 1
#   City.create(
#     name: indian_cities[j - 1],
#     state_id: j,
#   )
# end

10.times do |i|
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email(domain: "gmail.com"),
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.cell_phone_in_e164.gsub(/\+/, "00"),
    city_id: Faker::Number.between(from: 1, to: 10),
    role: "OWNER",
  )
end

10.times do |i|
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email(domain: "gmail.com"),
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.cell_phone_in_e164.gsub(/\+/, "00"),
    city_id: Faker::Number.between(from: 1, to: 10),
    role: "CUSTOMER",
  )
end

# # Restaurant Details
RestaurantDetail.create(name: "Nation 52", description: "Foodies welcome here", address: "Karvenagar", city_id: 1, user_id: 1)
RestaurantDetail.create(name: "Hayat!", description: "Spicyy jet!", address: "Baliwes", city_id: 2, user_id: 2)
RestaurantDetail.create(name: "Tammana", description: "House of Foodies", address: "Sector 52", city_id: 3, user_id: 3)
RestaurantDetail.create(name: "Hotel 360", description: "Craving alert!", address: "Sector 100", city_id: 8, user_id: 6)
RestaurantDetail.create(name: "JW Mariot", description: "Luxurious Ambience!", address: "Madgaon 141", city_id: 2, user_id: 7)
RestaurantDetail.create(name: "Lokpriya", description: "Roof top!", address: "Madgaon 141", city_id: 10, user_id: 5)
RestaurantDetail.create(name: "Spice n Ice", description: "Only for quick insures!", address: "Bavdhan 121", city_id: 10, user_id: 8)
RestaurantDetail.create(name: "Shanaya", description: "luxurious surroundings, comfort", address: "Ram nagar", city_id: 4, user_id: 9)
RestaurantDetail.create(name: "Karuna", description: "South indian express", address: "Balewadi", city_id: 10, user_id: 4)
RestaurantDetail.create(name: "KFC", description: "It's Finger Lickin' Good", address: "Gudgao", city_id: 1, user_id: 10)

# #============================   M e n u  ========================================

price = [100, 200, 300, 190, 90, 100, 180, 600, 90, 50, 150, 230, 480, 190, 90, 170, 180, 650, 90, 80, 100]
stock = [100, 50, 20, 40, 100, 20, 60, 40, 50, 70, 100, 50, 20, 40, 100, 20, 60, 40, 50, 70]
item_type = ["Beverage", "Desert", "main_course"]
rating = [0, 1, 2, 3, 4, 5]

100.times do |i|
  Menu.create(
    item_name: Faker::Food.dish,
    item_type: item_type.sample,
    price: price.sample,
    stock: stock.sample,
    rating: rating.sample,
    available: true,
    restaurant_detail_id: Faker::Number.between(from: 1, to: 10),
  )
end

# ==========================Cart Items=================================

MenuId = Menu.all.map(&:id)
cartId = Cart.all.map(&:id)
# puts "#{cartId}"
50.times do |i|
  quantity = Faker::Number.between(from: 1, to: 10)
  menuid = MenuId.sample
  CartItem.create(
    cart_id: cartId.sample,
    menu_id: MenuId.sample,
    qty: quantity,
    price: quantity * Menu.find(menuid).price,
  )
end

# ==========================Orders=========================

Order.create(id: 1, gross_amount: 1000, user_id: 11, status: "SUCCESS")
Order.create(id: 2, gross_amount: 2000, user_id: 12, status: "SUCCESS")
Order.create(id: 3, gross_amount: 500, user_id: 13, status: "SUCCESS")
Order.create(id: 4, gross_amount: 5000, user_id: 14, status: "SUCCESS")
Order.create(id: 5, gross_amount: 5000, user_id: 15, status: "SUCCESS")

# ==========================Order Items=========================
MenuId = Menu.all.map(&:id)
50.times do |i|
  menuid = MenuId.sample
  qty = Faker::Number.between(from: 1, to: 10)
  OrderItem.create(
    order_id: Faker::Number.between(from: 1, to: 5),
    menu_id: menuid,
    item_name: Menu.find(menuid).item_name,
    item_type: Menu.find(menuid).item_type,
    qty: qty,
    total_price: qty * Menu.find(menuid).price,
  )
end

# ===========================Ratings==================================

order_item_ids = OrderItem.all.map(&:id)
30.times do |i|
  Rating.create(
    order_item_id: order_item_ids[i],
    menu_id: OrderItem.find(order_item_ids[i]).menu_id,
    user_id: Order.find(OrderItem.find(order_item_ids[i]).order_id).user_id,
    rating: Faker::Number.between(from: 1, to: 5),
  )
end
