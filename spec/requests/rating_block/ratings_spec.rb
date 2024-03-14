require 'rails_helper'

RSpec.describe RatingBlock::RatingsController, type: :controller do
  
  let(:user) { UserBlock::User.create(name:"nitish", email:"nitish@gmail.com",password:"Nksingh")}
  let(:property) { PropertyBlock::Property.create(property_name:"Test Property", size:"100 sq feet", location:"hyderabad", user: user) } 
  let(:rating) { RatingBlock::Rating.create(property: property, user: user, value: 5 )}
  let(:token) { JwtToken.encode_token(user.id)}
  
  describe "GET /index" do
    it "give the response ok" do
      request.headers['token'] = token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("All property rating with user")
    end
  end

  describe "POST /create" do
    it "give the response ok" do
      request.headers['token'] = token
      post :create, params: { property_id: property.id, rating_value: 5}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Rating is given successfully..")
    end

    it "give the response ok" do
      request.headers['token'] = token
      post :create, params: { property_id: property.id}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['errors']).to eq(["Value can't be blank", "Value Rating value must be between 1 and 5"])
    end
  end

  describe "PUT/update" do
    it "give the response ok" do
      request.headers['token'] = token
      put :update, params: { id: rating.id, value: 4 }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("rating updated successfully..")
    end

    it "give the response ok" do
      request.headers['token'] = token
      post :create, params: { property_id: property.id}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['errors']).to eq(["Value can't be blank", "Value Rating value must be between 1 and 5"])
    end
  end

  describe "DELETE/destroy" do
    it "give the response ok" do
      request.headers['token'] = token
      delete :destroy, params: { id: rating.id }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Rating is deleted successfully")
    end
  end
end









#   def destroy 
#     rating = RatingBlock::Rating.find[:id]
#     render json: { rating: rating.destroy, message: 'Rating is deleted successfully' },status: 200
#   end