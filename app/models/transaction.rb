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
      
end