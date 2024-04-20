class OrderSerializer < ActiveModel::Serializer
  attributes :id, :gross_amount, :status, :user_id
end