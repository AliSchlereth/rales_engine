class Api::V1::InvoiceItems::SearchController < ApplicationController
  
  def index
    render json: InvoiceItem.where(valid_search_parameters)
  end
  
  def show
    render json: InvoiceItem.find_by(valid_search_parameters)
  end
  
  private
  
  def valid_search_parameters
    params.permit(:quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
  
  
end