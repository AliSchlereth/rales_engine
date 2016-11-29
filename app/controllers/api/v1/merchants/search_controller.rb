class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: Merchant.find_by(valid_search_parameters)
  end

  private

  def valid_search_parameters
    params.permit(:name, :created_at, :updated_at)
  end

end