class Customer < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.customer_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
  
  def self.find_customer(params)
    find_by(valid_search_parameters(params))
  end
  
  def self.find_all_customers(params)
    where(valid_search_parameters(params))
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
  
end