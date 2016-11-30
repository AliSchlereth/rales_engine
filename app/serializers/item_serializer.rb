class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :description, :unit_price
end
