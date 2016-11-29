class Api::V1::Invoices::RandomController < ApplicationController
  
  def show
    render json: Invoice.invoice_randomizer
  end
  
end