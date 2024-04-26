FactoryBot.define do
  factory :restaurant_detail do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    description { "Spicyy jetttt" }
    city_id { 10 }
    association :user
    association :city
  end
end
