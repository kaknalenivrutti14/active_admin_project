class FavoriteBlock::FavoritesController < ApplicationController

  before_action :authenticate_user

  def create 
    @property = PropertyBlock::Property.find(params[:property_id])
    favorite = FavoriteBlock::Favorite.new(property_id: @property.id, user_id: @current_user.id)
    if favorite.save
      render json: { favorite_property: FavoriteBlock::FavoriteSerializer.new(favorite), messages: 'Your favorite property is added to favorite list'}, status: 200
    else
      render json: {errors: favorite.errors.messages, message: 'Your favorite property is not add to favorite list'}, status: 422
    end
  end

  def index 
    favorite_properties = @current_user.favorite_properties
    render json: { favorite_properties: FavoriteBlock::FavoriteSerializer.new(favorite_properties).serializable_hash, message: 'Favorite properties list data' }, status: 200
  end

  def destroy
    favorite = @current_user.favorite_properties.find(params[:id])
    render json: {favorite_property: favorite.destroy, message: 'This property is removed from your favorite list' }, status: 200
  end

end
