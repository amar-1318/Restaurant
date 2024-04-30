FactoryBot.define do
  factory :rating do
    association :user
    association :order_item
    rating { }
    menu_id { }
  end
end
