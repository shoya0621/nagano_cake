class Public::AddressesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
     redirect_to addresses_path
    else
     flash[:message] = "入力に不備があります"  
     redirect_to addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
