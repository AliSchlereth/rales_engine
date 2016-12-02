require 'rails_helper'

describe "customer business intelligence endpoints" do
  context "returns a merchant where a customer has conducted the most successful transactions" do
    it "returns a single merchant" do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice1.id)
      transaction3 = create(:transaction, invoice_id: invoice2.id)
      
      get "/api/v1/customers/#{customer.id}/favorite_merchant"
      
      result = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(result.merchant_id).to eq(merchant1.id)
      expect(result.name).to eq(merchant1.name)
    end
  end
end