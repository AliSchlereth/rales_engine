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
end
