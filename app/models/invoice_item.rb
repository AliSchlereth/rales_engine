class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true
  
  belongs_to :item
  belongs_to :invoice
  
  def self.invoice_item_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
  
  def self.find_invoice_item(params)
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      find_by(unit_price: price)
    else
      find_by(valid_search_parameters(params))
    end
  end
  
  def self.find_all_invoice_items(params)
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      where(unit_price: price)
    else
      where(valid_search_parameters(params))
    end
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
  
end