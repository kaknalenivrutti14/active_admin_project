require 'rails_helper'

RSpec.describe PropertyBlock::PropertiesController, type: :controller do
 before(:each) do 
    @user1 = FactoryBot.create(:user_block_user, email: "nitish12@gmail.com", password:"123456")
    @user = FactoryBot.create(:user_block_user)
    @property = FactoryBot.create(:property_block_property, user_id: @user1.id)
    @token = JwtToken.encode_token(@user.id)
    @valid_parmas = { "property":{ "property_name": "grukul_property", "size": "2100 sq feet","cost": 150000, "location":"indore" }}
    @invalid_parmas = { "property":{ "property_name":'', "size": "2100 sq feet","cost": 150000, "location":"indore" }}

  end

  describe "POST/CREATE" do
    it "Response is getting ok" do 
      request.headers['token'] = @token
      post :create, params: @valid_parmas
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Property created successfully..")
    end

    it "Response is getting unprocessable_entity " do 
      request.headers['token'] = @token
      post :create, params: @invalid_parmas
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["errors"]["property_name"]).to eq(["can't be blank, Please fill the property name"])
    end
  end

  describe "GET/INDEX" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq('Properties details')
    end
  end

  describe "GET/SHOW" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :show, params: {id: @property.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq('Property details')

    end
  end

  describe "GET/OWNER_PROPERTY" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :owner_property
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Your created properties details")

    end
  end


  describe "GET/CURRENT_USER_PROPERTY" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :current_user_booked_property
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Your booked properties details")

    end
  end

  describe "DELETE/DESTROY" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      delete :destroy, params: {id: @property.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Property deleted successfully...")
    end
  end
end
