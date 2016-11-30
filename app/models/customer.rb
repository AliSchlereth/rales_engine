class Customer < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.customer_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
end
