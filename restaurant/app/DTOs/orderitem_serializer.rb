class OrderitemSerializer < ActiveModel::Serializer
  attributes :id ,:order_id, :item_name, :item_type, :qty, :total_price, :menu_id 
end