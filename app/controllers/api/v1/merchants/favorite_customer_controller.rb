class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  
  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.single_merchant_favorite_customer 
  end
  
end