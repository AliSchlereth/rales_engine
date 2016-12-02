class Merchant < ActiveRecord::Base
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  def self.merchant_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end

  def self.most_revenue(quantity)
    find_merchants_with_successful_transactions
                                                    .group(:id)
                                                    .order("sum(quantity * unit_price) DESC")
                                                    .limit(quantity)
  end

  def self.most_items(quantity)
    find_merchants_with_successful_transactions
                                                    .group(:id)
                                                    .order("sum(invoice_items.quantity) DESC")
                                                    .limit(quantity)
  end
  
  def self.revenue_by_date(date)
    find_merchants_with_successful_transactions
                                                    .where("invoices.created_at = '#{date}'")
                                                    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
  
  def single_merchant_revenue(date = nil)
    if date.nil?
      find_successful_transactions_for_single_merchant
                                                    .sum("invoice_items.quantity * invoice_items.unit_price")
    else
      find_successful_transactions_for_single_merchant
                                                    .where("invoices.created_at = '#{date}'")
                                                    .sum("invoice_items.quantity * invoice_items.unit_price")
    end
  end
  
  def single_merchant_favorite_customer
    customers.joins(:transactions).merge(Transaction.success)
                                                    .group(:id)
                                                    .order("transactions.count DESC")
                                                    .first  
  end   
  
  def customers_with_pending_invoices
    Customer.find_by_sql("SELECT customers.* FROM customers
                          INNER JOIN invoices ON invoices.customer_id = customers.id 
                          WHERE invoices.merchant_id = #{self.id}
                          EXCEPT
                          SELECT customers.* FROM customers
                          INNER JOIN invoices ON invoices.customer_id = customers.id 
                          INNER JOIN transactions ON transactions.invoice_id = invoices.id 
                          WHERE invoices.merchant_id=#{self.id} AND transactions.result ='success'")  
  end
  
  private
  
  def self.find_merchants_with_successful_transactions
    joins(invoices: [:invoice_items, :transactions]).merge(Transaction.success)
  end
    
  def find_successful_transactions_for_single_merchant
    invoices.joins(:transactions, :invoice_items).merge(Transaction.success)
  end
      
end
