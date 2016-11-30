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
  
  context 'GET /api/v1/invoices/:id/invoice_items' do
    it "returns invoice items associated with an invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
      invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"
      
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result.count).to eq(3)
    end
  end
  
  context 'GET /api/v1/invoices/:id/items' do
    it "returns items associated with an invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice.id)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice.id)
      
      get "/api/v1/invoices/#{invoice.id}/items"
      
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result.count).to eq(3)
    end
  end
end