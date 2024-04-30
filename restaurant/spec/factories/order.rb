FactoryBot.define do
  factory :order do
    user
    gross_amount { 180 }
    status { "pending" }
  end
end
