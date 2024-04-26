roles = ["ADMIN", "OWNER", "CUSTOMER"]

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "madhekarawmar@123.com" }
    password { "Amar@123" }
    address { Faker::Address.full_address }
    contact { Faker::PhoneNumber.cell_phone_in_e164.gsub(/\+/, "00") }
    role { roles.sample }
    association :city
  end
end
