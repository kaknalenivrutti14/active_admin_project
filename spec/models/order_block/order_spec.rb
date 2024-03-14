require 'rails_helper'

RSpec.describe OrderBlock::Order, type: :model do
  let(:user) { UserBlock::User.create(name: 'Test User', password:'12345', email:"nitish@gmail.com") }
  let(:property) { PropertyBlock::Property.create(property_name: 'Test Property', size:'400sq feet', location:"hyderabad", user:user) }
  
  it 'validates uniqueness of property_id scoped to user' do
    order = OrderBlock::Order.new(user: user, property: property)
    expect(order).to be_valid
    order.save
    duplicate_order = OrderBlock::Order.new(user: user, property: property)
    expect(duplicate_order).not_to be_valid
  end

  it 'sets property status to true after creation' do
    order = OrderBlock::Order.create(user: user, property: property)
    expect(property.reload.is_sold).to be true
  end

  it 'sets property status to false after deletion' do
    order = OrderBlock::Order.create(user: user, property: property)
    order.destroy
    expect(property.reload.is_sold).to be false
  end
end
