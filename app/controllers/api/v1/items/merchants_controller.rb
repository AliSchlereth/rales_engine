class Api::V1::Items::MerchantsController < ApplicationController

  def show
    item = Item.find(params[:item_id])
    render json: item.merchant
  end


end
