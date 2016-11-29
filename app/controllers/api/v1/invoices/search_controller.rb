class Api::V1::Invoices::SearchController < ApplicationController
  
  def index
    render json: Invoice.where(valid_search_parameters)
  end
  
  def show
    render json: Invoice.find_by(valid_search_parameters)
  end
  
  private
  
  def valid_search_parameters
    params.permit(:status, :customer_id, :merchant_id, :created_at, :updated_at)
  end
  
  
end