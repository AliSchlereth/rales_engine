require 'rails_helper'

describe "GET /api/v1/transactions/:id/invoice" do
  context "a single transaction's invoice" do
    it "returns only the invoice associated with the transaction" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id)
      transaction_2 = create(:transaction, invoice_id: invoice_2.id)
      
      get "/api/v1/transactions/#{transaction_1.id}/invoice"
      
      json_transaction_invoice = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_transaction_invoice["id"]).to eq(invoice_1.id)
    end
  end
end