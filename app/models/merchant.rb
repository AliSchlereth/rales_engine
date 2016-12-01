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

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions]).merge(Transaction.success)
                                                    .group(:id)
                                                    .order("sum(quantity * unit_price) DESC")
                                                    .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions]).merge(Transaction.success)
                                                    .group(:id)
                                                    .order("sum(invoice_items.quantity) DESC")
                                                    .limit(quantity)
  end
  
  def self.revenue_by_date(date)
    joins(invoices: [:invoice_items, :transactions]).merge(Transaction.success)
                                                    .where("invoices.created_at = '#{date}'")
                                                    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
  
  def single_merchant_revenue
    invoices.joins(:transactions, :invoice_items).merge(Transaction.success)
                                                  .sum("invoice_items.quantity * invoice_items.unit_price")
  end
  
  def self.successful
    alskdjflaksjdfkj
  end

end
