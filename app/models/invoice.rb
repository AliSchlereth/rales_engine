class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant
  
  def self.invoice_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end

  def self.find_invoice(params)
    find_by(valid_search_parameters(params))
  end
  
  def self.find_all_invoices(params)
    where(valid_search_parameters(params))
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
  end
  
end