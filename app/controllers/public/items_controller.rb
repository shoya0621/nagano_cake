class Public::ItemsController < ApplicationController
  def index
    @item_counts = Item.where(is_active: true)
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
