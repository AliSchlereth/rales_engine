class Merchant < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :items
  has_many :invoices
end
