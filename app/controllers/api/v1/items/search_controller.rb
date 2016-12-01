class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(valid_search_parameters)
  end

  def show
    if params[:unit_price]
      price = params[:unit_price].to_i * 100
      # binding.pry
      render json: Item.find_by(unit_price: "#{price}".to_i)
    else
      render json: Item.find_by(valid_search_parameters)
    end
  end

  private

  def valid_search_parameters
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end

end
