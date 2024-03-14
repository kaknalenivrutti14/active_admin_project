require 'rails_helper'

RSpec.describe OrderBlock::OrdersController, type: :controller do
  before(:each) do 
    @user1 = FactoryBot.create(:user_block_user, email: "nitish12@gmail.com", password:"123456")
    @user = FactoryBot.create(:user_block_user)
    @property = FactoryBot.create(:property_block_property, user_id: @user1.id)
    @order = FactoryBot.create(:order_block_order, user_id: @user1.id, property_id: @property.id)
    @token = JwtToken.encode_token(@user.id)
    @valid_parmas = { "order":{ "property_id": @property.id } }
    @invalid_parmas = { "order":{ "property_id": 13 }}
  end

  describe "POST/CREATE" do
    it "Response is getting ok" do 
      request.headers['token'] = @token
      post :create, params: @valid_parmas
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Order created successfully...")
    end

    it "Response is getting not found " do 
      request.headers['token'] = @token
      post :create, params: @invalid_parmas
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)["error"]).to eq("Record not found")

    end
  end

  describe "GET/INDEX" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("order list")
    end
  end

  describe "GET/SHOW" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      get :show, params: {id: @order.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq(" Order details")
    end
  end

  describe "DELETE/DESTROY" do
    it "Response is getting OK " do 
      request.headers['token'] = @token
      delete :destroy, params: {id: @order.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Order is deleted successfully..")
    end
  end
end
