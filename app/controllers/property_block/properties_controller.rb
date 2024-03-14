module PropertyBlock
  class PropertiesController < ApplicationController

  before_action :authenticate_user
  before_action :set_property, only: [:update, :show, :destroy]
    
    def create
      property = @current_user.properties.build(property_params)
      if property.save
        render json: { propery_data: property, message: 'Property created successfully..' }, status: :ok
      else
        render json: { errors: property.errors.messages}, status: :unprocessable_entity
      end
    end

    def index
      properties = PropertyBlock::Property.where.not(user_id: @current_user.id)
      render json: { property_data: PropertyBlock::PropertySerializer.new(properties, params: { current_user: @current_user }).serializable_hash, message: 'Properties details'}, status: :ok
    end

    def owner_property
      properties = @current_user.properties
      render json: { property_data: PropertyBlock::PropertySerializer.new(properties).serializable_hash, message: 'Your created properties details'}, status: :ok
    end

    def current_user_booked_property
      properties = PropertyBlock::Property.joins(:orders).where(orders: {user_id: @current_user.id } )
      render json: { property_data: PropertyBlock::PropertySerializer.new(properties).serializable_hash, message: 'Your booked properties details'}, status: :ok
    end

    def update
      if @property.update(property_params)
        render json: {property: @property, message:'Property updated successfully...'}, status: :ok
      else
        render json: {errors: @property.errors.full_messages},status: :unprocessable_entity
      end
    end

    def show 
      property = PropertyBlock::Property.find(params[:id])
      render json: { property: property, message:"Property details" }, status: :ok
    end

    def destroy
      if @property.destroy
        render json: { property: @property, message: 'Property deleted successfully...'}, status: :ok
      end
    end

    private

    def property_params
      params.require(:property).permit(:property_name, :size, :location, :cost)
    end

    def set_property 
      @property = PropertyBlock::Property.find(params[:id])
    end
  end
end
