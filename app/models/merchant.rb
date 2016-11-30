class Merchant < ActiveRecord::Base
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items


  def self.merchant_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end

  def self.most_revenue(qty)
    # binding.pry
    # The invoices of a Merchant where their transaction is successful
    # find the invoice items from those invoices
    # calculate the revenue (qty * price)
    joins(invoices: [:invoice_items, :transactions]).where(transactions: {result: 'success'})
                                                   .group(:id)
                                                   .order("sum(quantity * unit_price) DESC")
                                                   .limit(qty)
  end

end
