class Public::OrdersController < ApplicationController
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
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    
  end

  def complete
  end

  def create
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

  def index
  end

  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :payment)
  end
  
end
