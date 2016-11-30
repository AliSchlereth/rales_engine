class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    render json: invoice_item.item
  end

end
