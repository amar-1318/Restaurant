class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :contact, :role, :email, :city_id, :gender
end
