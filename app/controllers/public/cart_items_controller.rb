class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
   if customer_signed_in?
    @cart_items = CartItem.where(customer_id: current_customer.id)
     @cart_items.each do |cart_item|
      if !(cart_item.item.is_active)
        cart_item.destroy
      end
     end
    @cart_item = CartItem.new
    @total = 0
   else
    redirect_to root_path
   end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer.id)
     cart_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer.id)
     cart_item.amount += @cart_item.amount
     cart_item.save
    else
     @cart_item.save
    end
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)

  end
end
