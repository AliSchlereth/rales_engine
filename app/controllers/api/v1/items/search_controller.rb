class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(valid_search_parameters)
  end

  def show
    render json: find_item(valid_search_parameters)
  end
  
  private
  
  def find_item(params)
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      Item.find_by(unit_price: price)
    elsif params[:created_at]
      Item.where(created_at: params[:created_at]).order(:id).first
    elsif params[:updated_at]
      Item.where(updated_at: params[:updated_at]).order(:id).first
    else
      Item.find_by(valid_search_parameters)
    end
  end
  
  def valid_search_parameters
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end  


end