require 'rails_helper'


describe "items relationship endpoints" do
  context 'GET /api/v1/invoices/:id/transactions' do
    it "returns transactions associated with an invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction_1 = create(:transaction, invoice_id: invoice.id)
      transaction_2 = create(:transaction, invoice_id: invoice.id)
      transaction_3 = create(:transaction, invoice_id: invoice.id)
      
      get "/api/v1/invoices/#{invoice.id}/transactions"
      
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result.count).to eq(3)
    end
  end
end