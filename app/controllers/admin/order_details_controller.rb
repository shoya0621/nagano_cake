class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    order = Order.find(order_detail.order_id)
    order_details = OrderDetail.where(order_id: order.id).where.not(production_status: "complete")
    
    if order_detail.production_status == "making"
        order.update(status: "making")
    end
    
    if order_details.empty?
        order.update(status: "prepare")
    end
    
    redirect_to admin_order_path(order_detail.order.id)
    
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
  
end
