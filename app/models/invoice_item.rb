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
  
end