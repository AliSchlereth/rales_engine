class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: Transaction.find_by(valid_search_parameters)
  end

  def index
    render json: Transaction.where(valid_search_parameters)
  end

  private
  def valid_search_parameters
    params.permit(:credit_card_number, :result, :invoice_id, :created_at, :updated_at)
  end

end
