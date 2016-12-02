require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "validations" do
    it "is invalid without a credit_card_number" do
      transaction = Transaction.new(result: "success", invoice_id: 1)
      expect(transaction).to_not be_valid
    end

    it "is invalid without a result" do
      transaction = Transaction.new(credit_card_number: 123, invoice_id: 1)
      expect(transaction).to_not be_valid
    end

    it "is invalid without an invoice" do
      transaction = Transaction.new(credit_card_number: 123, result: "Success")
      expect(transaction).to_not be_valid
    end

    it "is valid with a result, credit_card_number, and invoice_id" do
      invoice = create(:invoice)
      transaction = Transaction.create(credit_card_number: 123, result: "success", invoice: invoice)
      expect(transaction).to be_valid
    end
  end

  context "relationships" do
    it "resonds to invoice" do
      invoice = create(:invoice)
      transaction = Transaction.create(credit_card_number: 123, result: "success", invoice: invoice)
      expect(transaction).to respond_to(:invoice)
    end
  end

  context "scope" do
    it "success only returns successful transactions" do
      invoice = create(:invoice)
      transaction1 = Transaction.create(credit_card_number: 123, result: "success", invoice: invoice)
      transaction2 = Transaction.create(credit_card_number: 123, result: "failed", invoice: invoice)
      valid = Transaction.success

      expect(valid[0].id).to eq(transaction1.id)
    end

    it "failed only returns failed transactions" do
      invoice = create(:invoice)
      transaction1 = Transaction.create(credit_card_number: 123, result: "success", invoice: invoice)
      transaction2 = Transaction.create(credit_card_number: 123, result: "failed", invoice: invoice)
      valid = Transaction.failed

      expect(valid[0].id).to eq(transaction2.id)
    end
  end
  
  context "transaction randomizer" do
    it "returns a random transaction" do
      transaction1, transaction2 = create_list(:transaction, 2)
      
      result = [Transaction.transaction_randomizer]
      expect(result.count).to eq(1)
      expect(result[0].credit_card_number).to be_truthy      
    end
  end

end
