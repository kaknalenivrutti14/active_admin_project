class OrderBlock::OrdersController < ApplicationController

  before_action :authenticate_user
  before_action :set_property, only: [:create]
  before_action :set_order, only: [:show, :destroy]

  def create
    order = @current_user.orders.build(order_params)
    order.property_id = @property.id

    if order.save
      razorpay = Razorpay::Order.create({"currency":"INR", "amount":(@property.cost*100).to_i})
      order.update(order_id:razorpay.id)
      render json: { order: order, message: 'Order created successfully...'},status:200
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end

  end

  def index
    orders = @current_user.orders
    render json: { orders: OrderBlock::OrderSerializer.new(orders).serializable_hash, message: 'order list'},status:200
  end

  def show
    render json: { order: @order, message:' Order details'}, status:200
  end

  def destroy
    if @order.destroy
      render json: { message: 'Order is deleted successfully..'}, status: 200
    else
      render json: { errors: 'Order is deletion failed'}, status: 200
    end

  end

  private

  def set_property
    @property = PropertyBlock::Property.where.not(user_id: @current_user.id).find(order_params[:property_id])
  end

  def set_order
    @order = OrderBlock::Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_id, :property_id, :currency)
  end

end
