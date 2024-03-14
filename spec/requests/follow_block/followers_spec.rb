require 'rails_helper'

RSpec.describe FollowBlock::FollowersController, type: :controller do
  before(:each) do 
    @user1 = FactoryBot.create(:user_block_user, email: "nitish12@gmail.com", password:"123456")
    @user = FactoryBot.create(:user_block_user)
    @token = JwtToken.encode_token(@user.id)
  end

  describe "POST/follow" do
    it "Response is getting ok" do 
      request.headers['token'] = @token
      post :follow, params: {user_id: @user1.id}
      expect(response).to have_http_status(200)
    end

    it "Response is getting not found " do 
      request.headers['token'] = @token
      post :follow, params: {user_id: @user.id}
      expect(response).to have_http_status(422)
    end

    it "Response is getting not found " do 
      request.headers['token'] = @token
      post :follow, params: {user_id: 17}
      expect(response).to have_http_status(404)
    end
  end

 describe "GET/following_list" do
    it "Response is getting ok" do 
      request.headers['token'] = @token
      get :following_list
      expect(response).to have_http_status(200)
    end
  end

  describe "GET/follower_list" do
    it "Response is getting ok" do 
      request.headers['token'] = @token
      get :follower_list
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET/unfollow" do
    before do 
      FactoryBot.create(:follow_block_follower, follower_id: @user.id, following_id: @user1.id)
    end
    it "Response is getting ok" do 
      request.headers['token'] = @token
      delete :unfollow, params: {user_id: @user1.id}
      expect(response).to have_http_status(200)
    end
  end

end
