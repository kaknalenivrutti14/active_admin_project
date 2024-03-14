class RatingBlock::RatingsController < ApplicationController

  before_action :authenticate_user
 

  def create
    @property = PropertyBlock::Property.find(params[:property_id])
    rating = @current_user.ratings.build(property_id: @property.id)
    rating.value = params[:rating_value]
    if rating.save
      render json: {rating: rating, message: 'Rating is given successfully..'}, status: 200
    else
      render json: {errors: rating.errors.full_messages }, status: 422
    end
  end

  def index 
    ratings = RatingBlock::Rating.all
    render json: { rating_data: RatingBlock::RatingSerializer.new(ratings).serializable_hash, message: "All property rating with user" },status: 200
  end

  def update 
    rating = @current_user.ratings.find(params[:id])
    if rating.update(value:params[:value])
      render json: { rating: rating, message: "rating updated successfully.." },status: 200
    else
      render json: { errors: rating.errors.full_messages }, status: 422
    end
  end

  def destroy 
    rating = RatingBlock::Rating.find(params[:id])
    render json: { rating: rating.destroy, message: 'Rating is deleted successfully' },status: 200
  end

end
