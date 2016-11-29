class Api::V1::Merchants::SearchController < ApplicationController

  def show
    search_area = params.keys.first
    search_target = params.values.first
    render json: Merchant.find_by("#{search_area}": "#{search_target}")
  end

end
