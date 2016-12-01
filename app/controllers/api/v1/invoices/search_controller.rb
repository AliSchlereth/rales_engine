class Api::V1::Invoices::SearchController < ApplicationController
  
  def index
    render json: Invoice.find_all_invoices(params)
  end
  
  def show
    render json: Invoice.find_invoice(params)
  end
  
end