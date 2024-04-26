FactoryBot.define do
  factory :city do
    association :state
    name { "#{Faker::Address.city}" }
    pincode { "413002" }
  end
end
