indian_states = [
  "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
  "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Maharashtra"
]


indian_cities = [
"Vijayawada",
"Naharlagun",
"Silchar",
"Gaya",
"Bhilai",
"Vasco da Gama",
"Surat",
"Gurgaon",
"Dharamshala",
"Pune"
]

roles = ["CUSTOMER", "OWNER"]

require "faker"

10.times do |i|
  State.create(
    name:indian_states[i], 
    id:i+1
  )
end

11.times do |j|
  City.create(
    name:indian_cities[j-1], 
    state_id:j,
    id:j,
    )
    j+=1
end



10.times do |i|
  User.create(
    id:i+1,
    name: Faker::Name.name,
    email: Faker::Internet.email(domain: 'gmail.com'),
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.cell_phone_in_e164.gsub(/\+/, '00'),
    city_id: Faker::Number.between(from: 1, to: 10) ,
    role: roles.sample
  )
end







# Restaurant Details
RestaurantDetail.create(id:1,name:"Nation 52", description:"Foodies welcome here",address:"Karvenagar",city_id:1, user_id:1)
RestaurantDetail.create(id:2,name:"Hayat!", description:"Spicyy jet!",            address:"Baliwes",  city_id:2, user_id:2)
RestaurantDetail.create(id:3,name:"Tammana", description:"House of Foodies",      address:"Sector 52",  city_id:3, user_id:3)
RestaurantDetail.create(id:4,name:"Hotel 360", description:"Craving alert!",      address:"Sector 100",  city_id:8, user_id:6)
RestaurantDetail.create(id:5,name:"JW Mariot", description:"Luxurious Ambience!", address:"Madgaon 141",  city_id:2, user_id:7)
RestaurantDetail.create(id:6,name:"Lokpriya", description:"Roof top!", address:"Madgaon 141",  city_id:10, user_id:8)



#============================   M e n u  ========================================

price = [100,200,300,190,90,100,180,600,90,50,150,230,480,190,90,170,180,650,90,80,100]
stock = [100,50,20,40,100,20,60,40,50,70,100,50,20,40,100,20,60,40,50,70];

rating = [0,1,2,3,4,5]

owners = [1,2,3,6,7,8]

20.times do |i|
  Menu.create(
    id:i+1,
    item_name: Faker::Food.dish,
    item_type: Faker::Food.ethnic_category, 
    price: price[i],
    stock: stock[i],
    rating: rating.sample,
    available: true,
    restaurant_detail_id: owners.sample
  )
end


# ==========================Cart=================================

customers = [4,5,9,10]
Cart.create(id:1,user_id:customers[0]);
Cart.create(id:2,user_id:customers[1]);
Cart.create(id:3,user_id:customers[2]);
Cart.create(id:4,user_id:customers[3]);



# ==========================Cart Items=================================


customers = [4,5,9,10]
MenuId = Menu.all.map(&:id)
# puts "#{cartId}"
10.times do |i|
  quantity = Faker::Number.between(from:1,to:10);
  menuid = MenuId.sample
  CartItem.create(
      id:i+1,
      cart_id: Faker::Number.between(from: 1, to: 4),
      menu_id: MenuId.sample,
      qty: quantity,
      price: quantity*Menu.find(menuid).price
    )
  end
  
  # ==========================Orders=========================
  customers = [4,5,9,10]
  Order.create(id:1,gross_amount:1000,user_id:customers[0],status:"SUCCESS")
  Order.create(id:2,gross_amount:2000,user_id:customers[1],status:"SUCCESS")
  Order.create(id:3,gross_amount:500,user_id:customers[2],status:"SUCCESS")
  Order.create(id:4,gross_amount:5000,user_id:customers[3],status:"SUCCESS")
  
  
  # ==========================Order Items=========================
  MenuId = Menu.all.map(&:id)
  15.times do |i|
    menuid =  MenuId.sample
    qty = Faker::Number.between(from: 1,to:10)
    OrderItem.create(
        id:i+1,
        order_id: Faker::Number.between(from: 1,to:4),
        menu_id: menuid,
        item_name:  Menu.find(menuid).item_name, 
        item_type:  Menu.find(menuid).item_type,
        qty: qty,
        total_price: qty*Menu.find(menuid).price
      )
    end
    
    
# ===========================Ratings==================================
    
# customers = [4,5,9,10]
order_item_ids = OrderItem.all.map(&:id);   
15.times do |i|
  Rating.create(
    id:i+1, 
    order_item_id: order_item_ids[i],
    menu_id: OrderItem.find(order_item_ids[i]).menu_id,
    user_id: Order.find(OrderItem.find(order_item_ids[i]).order_id).user_id,
    rating: Faker::Number.between(from:1,to:5)
  )
end



