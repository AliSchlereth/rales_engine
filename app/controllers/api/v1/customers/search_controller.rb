class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: Customer.find_all_customers(params)
  end

  def show
    render json: Customer.find_customer(params)
  end
  
end