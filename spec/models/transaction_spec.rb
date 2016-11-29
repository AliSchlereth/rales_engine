require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "validations" do
    it "is invalid without a credit_card_number" do
      transaction = Transaction.new(result: "success", invoice_id: 1)
      expect(transaction).to_not be_valid
    end

    it "is invalid without a result" do
      transaction = Transaction.new(credt_card_number: 123, invoice_id: 1)
      expect(transaction).to_not be_valid
    end

    it "is valid with a result, credit_card_number, and invoice_id" do
      invoice = create(:invoice)
      transaction = Transaction.create(credt_card_number: 123, result: "success", invoice: invoice)
      expect(transaction).to be_valid
    end

  end

end
