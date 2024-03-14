class FollowBlock::FollowersController < ApplicationController

  before_action :authenticate_user
  before_action :set_user, only: [:follow]

  def follow 
    
    follow_user = FollowBlock::Follower.new
    follow_user.follower_id = @current_user.id
    follow_user.following_id = @user.id

    if follow_user.save
      render json: { data: FollowerBlock::FollowerSerializer.new(follow_user), message: "You successfully following to #{@user.name}"}, status: :ok
    else
      render json: { errors: follow_user.errors.full_message, message: 'You can not follow to this user' }, status: 422
    end
  end

  def following_list 
    following_list = @current_user.followings
    render json: {following_list: FollowerBlock::FollowerSerializer.new(following_list).serializable_hash, message:'Your following list' }, status: :ok
  end

  def follower_list
    follower_list = @current_user.followers
    render json: {follower_list: FollowerBlock::FollowerSerializer.new(follower_list).serializable_hash, message:'Your followers list' }, status: :ok
  end

  def unfollow
    following_user = @current_user.followings.find_by(following_id: params[:user_id])
    if following_user
      following_user.destroy
      render json: { message: "you successfully unfollow to this user" }, status: 200
    else
      render json: { message: "Following user not found" }, status:404
    end
  end

 
  private

  def set_user
    @user = UserBlock::User.find(params[:user_id])
    return render json: { message: "You cannot follow yourself" }, status: 422 if @user.id == @current_user.id

    if @current_user.followings.where(following_id: @user.id).empty?
      @user
    else
      render json: { message: "You are already following this user" }, status: 200
    end
  end

end
