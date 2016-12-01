class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true

  belongs_to :invoice

  scope :success, -> { where(result: 'success') }
  scope :failed,  -> { where(result: 'failed') }

  def self.transaction_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
    
  def self.find_transaction(params)
    find_by(valid_search_parameters(params))
  end

  def self.find_all_transactions(params)
    where(valid_search_parameters(params))
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :credit_card_number, :result, :invoice_id, :created_at, :updated_at)
  end

end