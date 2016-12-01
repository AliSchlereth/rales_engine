class Api::V1::Transactions::SearchController < ApplicationController

  def index
    render json: Transaction.find_all_transactions(params)
  end

  def show
    render json: Transaction.find_transaction(params)
  end

end
