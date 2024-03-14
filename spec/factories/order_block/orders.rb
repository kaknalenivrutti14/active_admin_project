FactoryBot.define do
  factory :order_block_order, class: 'OrderBlock::Order' do
    order_id { "hfksdf"}
    currency {"INR"}
    user_id { }
    property_id { }
    
  end
end
