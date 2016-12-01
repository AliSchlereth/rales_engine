class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.find_all_items(params)
  end

  def show
    render json: Item.find_item(params)
  end

end
