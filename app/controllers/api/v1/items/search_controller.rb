class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(valid_search_parameters)
  end

  def show
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      render json: Item.find_by(unit_price: price)
    elsif params[:created_at]
      item = Item.where(valid_search_parameters).order(:id).first
      render json: item
    else
      render json: Item.find_by(valid_search_parameters)
    end
  end

  private

  def valid_search_parameters
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end

end
