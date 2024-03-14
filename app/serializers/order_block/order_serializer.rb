class OrderBlock::OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :order_id, :user_id, :property_id
end
