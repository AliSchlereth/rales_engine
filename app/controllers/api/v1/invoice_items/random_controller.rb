class Api::V1::InvoiceItems::RandomController < ApplicationController
  
  def show
    render json: InvoiceItem.invoice_item_randomizer
  end
  
end