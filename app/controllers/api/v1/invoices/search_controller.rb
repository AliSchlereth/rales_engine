class Api::V1::Invoices::SearchController < ApplicationController
  def show
    search_area = params.keys.first
    search_target = params.values.first
    render json: Invoice.find_by("#{search_area}": "#{search_target}")
  end
  
end