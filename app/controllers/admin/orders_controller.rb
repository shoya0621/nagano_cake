class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = 0
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    
     if order.status == "comfirm"
       order_details = OrderDetail.where(order_id: order.id)
        order_details.each do |order_detail|
         order_detail.update(production_status: "wait")
        end 
     end   
      
    redirect_to admin_order_path(params[:id])
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
