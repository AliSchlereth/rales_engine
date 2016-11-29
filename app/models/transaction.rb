class Transaction < ApplicationRecord
  validates :credt_card_number, presence: true
  validates :result, presence: true

  belongs_to :invoice
end
