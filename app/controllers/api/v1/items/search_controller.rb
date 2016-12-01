class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(valid_search_parameters)
  end

  def show
    render json: Item.find_item(params)
  end

  private

  def valid_search_parameters
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end

end
