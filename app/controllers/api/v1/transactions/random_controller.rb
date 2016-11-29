class Api::V1::Transactions::RandomController < ApplicationController

  def show
    render json: Transaction.transaction_randomizer
  end

end
