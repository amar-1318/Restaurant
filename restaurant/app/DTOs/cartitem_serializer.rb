class CartitemSerializer < ActiveModel::Serializer
  attributes :id ,:cart_id, :qty, :price, :menu_id 
end