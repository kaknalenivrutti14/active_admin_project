require 'rails_helper'

RSpec.describe RatingBlock::Rating, type: :model do
  
  let(:user) {UserBlock::User.create(email:"nitish@gmail.com", password:"Nitish@96",name:"Nitish kumar")}
  let(:property) {PropertyBlock::Property.create(property_name:"Birla Property", size:"19000 sq feet", location:"hyderabad", user:user)}
  let(:rating) { RatingBlock::Rating.create(user: user, property:property, value:5 )}

    it "validate uniqueness of property scope to user it take only uniq record" do 
     rating = RatingBlock::Rating.new(property:property, user:user, value: 5)
      expect(rating).to be_valid
      rating.save
      duplicate_rating = RatingBlock::Rating.new(property:property, user:user, value: 5)
      expect(duplicate_rating).not_to be_valid
    end
end
