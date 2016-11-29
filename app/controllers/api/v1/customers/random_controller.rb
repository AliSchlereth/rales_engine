class Api::V1::Customers::RandomController < ApplicationController

  def show
    render json: Customer.customer_randomizer
  end
end
