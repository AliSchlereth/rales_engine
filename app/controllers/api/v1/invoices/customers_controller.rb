class Api::V1::Invoices::CustomersController < ApplicationController

  def show
    invoice = Invoice.find(params[:invoice_id])
    render json: invoice.customer
  end


end
