class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.merchant_randomizer
  end

end
