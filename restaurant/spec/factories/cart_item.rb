FactoryBot.define do
  factory :cart_item do
    transient do
      quantity { Faker::Number.between(from: 1, to: 20) }
    end
    association :cart
    association :menu
    qty { quantity }
    price { menu.price * quantity }
  end
end
