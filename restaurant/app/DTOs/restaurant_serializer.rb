class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address,:description
end