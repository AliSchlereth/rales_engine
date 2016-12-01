class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItem.find_all_invoice_items(params)
  end

  def show
    render json: InvoiceItem.find_invoice_item(params)
  end

end
