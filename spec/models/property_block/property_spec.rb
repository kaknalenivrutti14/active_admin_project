require 'rails_helper'

RSpec.describe PropertyBlock::Property, type: :model do
  # let(:user) { UserBlock::User.create(name:"nitish", email:"nitish@gmail.com", password:"123456")}
  # let(:propety) { PropertyBlock::Property.create(prperty_name:"Test", size:"26 sq feet", location:"jaipur", user:user )}
  describe "Association" do
    it { should belong_to(:user).class_name("UserBlock::User") }
    it {should have_many(:orders).class_name("OrderBlock::Order") }
  end

  describe "Validation" do
    it {should validate_presence_of(:property_name).with_message("can't be blank, Please fill the property name") }
    it {should validate_uniqueness_of(:property_name).with_message("is already taken, Please take another name") }
    it {should validate_presence_of(:size).with_message("can't be blank, please fill the property size") }
    it {should validate_presence_of(:location).with_message("can't be blank, please fill the address of property")}
  end

  describe "rating_avg_rating" do 
    let!(:user) { UserBlock::User.create(name:"nitish", email:"nitish@gmail.com", password:"123456")}
    let!(:property) { PropertyBlock::Property.create(property_name:"Test", size:"26 sq feet", location:"jaipur", user:user )}
    
    it "validate the averge of prperty rating value" do 
  
      rating = RatingBlock::Rating.create(user:user, property:property, value: 5)
      property.average_rating
    
    end
  end
end
