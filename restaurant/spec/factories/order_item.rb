FactoryBot.define do
  factory :order_item do
    association :order
    menu_id { }
    item_name { }
    item_type { }
    qty { }
    total_price { }
  end
end
