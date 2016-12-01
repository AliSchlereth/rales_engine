class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue_by_date(params[:date]), serializer: TotalRevenueSerializer
  end
  
  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.single_merchant_revenue, serializer: RevenueSerializer
  end

end
