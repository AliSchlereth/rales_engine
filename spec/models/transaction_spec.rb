require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "validations" do
    it "is invalid without a credit_card_number" do
      transaction = Transaction.new(result: "success", invoice_id: 1)
      expect(transaction).to_not be_valid
    end
  end

end
