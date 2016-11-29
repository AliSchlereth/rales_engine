class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    item = Item.find(params[:item_id])
    render json: item.invoice_items
  end

end
