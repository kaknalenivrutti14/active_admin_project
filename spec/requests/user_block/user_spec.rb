require 'rails_helper'

RSpec.describe UserBlock::UsersController, type: :controller do
  before(:each) do 
    @valid_parmas = { 
      "user":{
        "name":"Ramesh",
        "email":"ramesh1@gmail.com",
        "password":"123456"
      }
    }

    @invalid_parmas = { 
      "user":{
        "name":"Ramesh",
        "email":'',
        "password":"123456"
      }
    }
  end


  describe "POST/sign_up" do

    it "Response is getting ok" do 
      post :sign_up, params: @valid_parmas
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("User created successfully")
    end

    it "Response is getting unprocessable entity" do 
      post :sign_up, params: @invalid_parmas
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["errors"]["email"]).to eq(["can't be blank"])
    end
  end

  describe "POST/sign_in" do
    before do 
        user = FactoryBot.create(:user_block_user)
    end

    it "Response is getting ok" do 
      post :sign_in, params: {email:"nitish@gmail.com", password:"123456"}

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("User login successfully")
    end

    it "Response is getting unprocessable entity" do 
      post :sign_in, params: {email:"nitish1@gmail.com", password:"123456"}
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)["message"]).to eq("Invalid email")
    end
  end

end
