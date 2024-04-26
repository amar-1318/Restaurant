class MenuSerializer < ActiveModel::Serializer
  attributes :id, :item_name, :item_type, :price, :rating, :restaurant_detail_id, :stock, :available
end
