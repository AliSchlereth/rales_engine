class Item < ApplicationRecord
  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.item_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end

  def self.most_revenue(quantity)
    Item.joins(:invoice_items, invoices: :transactions).merge(Transaction.success)
                                                       .group(:id)
                                                       .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
                                                       .limit(quantity)
  end

  def self.most_items(quantity)
    Item.joins(:invoice_items, invoices: :transactions).merge(Transaction.success)
                                                       .group(:id)
                                                       .order("sum(invoice_items.quantity) DESC")
                                                       .limit(quantity)
  end

  def best_day
    invoices.joins(:transactions, :invoice_items).merge(Transaction.success).group(:created_at, :id).order("sum(invoice_items.quantity) DESC").first.created_at
  end
  
  def self.find_item(params)
    if params[:unit_price]
      price = ((params[:unit_price].to_f) * 100).round()
      find_by(unit_price: price)
    elsif params[:created_at]
      where(valid_search_parameters(params)).order(:id).first
    elsif params[:updated_at]
      where(valid_search_parameters(params)).order(:id).first
    else
      find_by(valid_search_parameters(params))
    end    
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end  
  
end
