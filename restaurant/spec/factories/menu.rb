price = [100, 200, 300, 190, 90, 100, 180, 600, 90, 50, 150, 230, 480, 190, 90, 170, 180, 650, 90, 80, 100]
stock = [100, 50, 20, 40, 100, 20, 60, 40, 50, 70, 100, 50, 20, 40, 100, 20, 60, 40, 50, 70]
rating = [0, 1, 2, 3, 4, 5]
item_types = ["Beverage", "Desert", "main_course"]

FactoryBot.define do
  factory :menu do
    transient do
      price_list { price }
      stock_list { stock }
      rating_list { rating }
    end
    item_name { Faker::Food.dish }
    item_type { item_types.sample }
    price { price_list.sample }
    stock { stock_list.sample }
    rating { rating_list.sample }
    available { true }
    association :restaurant_detail
  end
end
