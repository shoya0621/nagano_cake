class Public::OrdersController < ApplicationController
  
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      
    elsif params[:order][:address_select] == "1"
      if params[:order][:address_id]
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
      end
    end
    
    if !(@order[:payment_method].presence && @order[:postal_code].presence && @order[:address].presence && @order[:name].presence)
      flash[:notice] = "お届け先を選択してください"
      redirect_to new_order_path
    end
    
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    
  end

  def complete
  end

  def create
    if !(CartItem.find_by(customer_id: current_customer.id))
     flash[:massage] = "カート内に商品を追加してください"
     redirect_to cart_items_path
    else
     @order = Order.new(order_params)
     @order.customer_id = current_customer.id
     @order.shipping_fee = Order::ShippingFee
     @order.save
    
     CartItem.where(customer_id: current_customer.id).each do |cart_item| 
      @order_detail = OrderDetail.new 
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.quantity = cart_item.amount
      @order_detail.purchase_unit_price = cart_item.item.with_tax_price
      @order_detail.save
     end
    
    CartItem.where(customer_id: current_customer.id).destroy_all
    redirect_to  orders_complete_path
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
   
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :payment)
  end
  
end
