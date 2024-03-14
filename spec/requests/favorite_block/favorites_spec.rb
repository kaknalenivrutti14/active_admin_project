require 'rails_helper'

RSpec.describe FavoriteBlock::FavoritesController, type: :controller do
   
  let(:user) { UserBlock::User.create(name:"nitish", email:"nitish@gmail.com",password:"Nksingh")}
  let(:property) { PropertyBlock::Property.create(property_name:"Test Property", size:"100 sq feet", location:"hyderabad", user: user) } 
  let(:favorite) { FavoriteBlock::Favorite.create(property: property, user: user)}
  let(:token) { JwtToken.encode_token(user.id)}
  
  describe "GET /index" do
    it "give the response ok" do
      request.headers['token'] = token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("Favorite properties list data")
    end
  end

  describe "POST /create" do
    it "give the response ok" do
      request.headers['token'] = token
      post :create, params: { property_id: property.id }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['messages']).to eq("Your favorite property is added to favorite list")
    end

    it "give the response not found" do
      request.headers['token'] = token
      post :create, params: { property_id: 3}
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)['error']).to eq("Record not found")
    end
  end

  describe "DELETE /destroy" do
    it "give the response ok" do
      request.headers['token'] = token
      delete :destroy, params: { id: favorite.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eq("This property is removed from your favorite list")
    end
  end

end