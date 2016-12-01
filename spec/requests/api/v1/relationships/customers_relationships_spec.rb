require 'rails_helper'

describe "GET /api/v1/customers/:id/invoices" do
  context "a single customer's invoices" do
    it "returns only the invoices that belong to one customer" do
      merchant = create(:merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_1.invoices.create(status: "success", merchant_id: merchant.id)
      customer_1.invoices.create(status: "fail", merchant_id: merchant.id)
      customer_1.invoices.create(status: "success", merchant_id: merchant.id)
      customer_2.invoices.create(status: "success", merchant_id: merchant.id)
      customer_2.invoices.create(status: "fails", merchant_id: merchant.id)
      
      get "/api/v1/customers/#{customer_1.id}/invoices"
      
      json_customer_invoices = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(json_customer_invoices.count).to eq(3)
    end
  end
end

describe "GET /api/v1/customers/:id/transactions" do
  context "a single customer's transactions" do
    it "returns only the transactions that belong to one customer" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_2 = create(:invoice, customer_id: customer_1.id)
      invoice_3 = create(:invoice, customer_id: customer_2.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id)
      transaction_2 = create(:transaction, invoice_id: invoice_2.id)
      transaction_3 = create(:transaction, invoice_id: invoice_3.id)
      
      get "/api/v1/customers/#{customer_1.id}/transactions"
      
      json_customer_transactions = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(json_customer_transactions.count).to eq(2)
    end
  end
end