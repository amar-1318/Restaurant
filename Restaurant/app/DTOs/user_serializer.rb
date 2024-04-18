class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :address,:contact,:role,:email
end