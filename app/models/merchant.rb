class Merchant < ActiveRecord::Base
  validates :name, presence: true

  has_many :items
  has_many :invoices


  def self.merchant_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
end
