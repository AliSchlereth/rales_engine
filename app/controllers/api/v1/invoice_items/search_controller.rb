class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      render json: InvoiceItem.where(unit_price: price)
    else
      render json: InvoiceItem.where(valid_search_parameters)
    end 
  end

  def show
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      render json: InvoiceItem.find_by(unit_price: price)
    else
      render json: InvoiceItem.find_by(valid_search_parameters)
    end
  end

  private

  def valid_search_parameters
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end


end
