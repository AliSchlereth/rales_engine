class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: find_all_invoice_items(valid_search_parameters(params))
  end

  def show
    render json: find_invoice_item(valid_search_parameters(params))
  end
  
  private
  
  def find_invoice_item(params)
    if params[:unit_price]
      price = price_converter(params)
      InvoiceItem.find_by(unit_price: price)
    else
      InvoiceItem.find_by(valid_search_parameters(params))
    end
  end
  
  def find_all_invoice_items(params)
    if params[:unit_price]
      price = price_converter(params)
      InvoiceItem.where(unit_price: price)
    else
      InvoiceItem.where(valid_search_parameters(params))
    end
  end
    
  def valid_search_parameters(params)
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
  
  def price_converter(params)
    price = ((params[:unit_price].to_f) * 100).round()
  end
  
end