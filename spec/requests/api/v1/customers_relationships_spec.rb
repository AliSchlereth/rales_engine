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

describe "GET /api/v1/merchants/:id/invoices" do
  context "a single merchant's invoices" do
    xit "returns only the invoices that belong to one merchant" do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_1.invoices.create(customer_id: customer.id, status: "success", merchant_id: merchant_1.id)
      merchant_1.invoices.create(customer_id: customer.id, status: "fail", merchant_id: merchant_1.id)
      merchant_1.invoices.create(customer_id: customer.id, status: "success", merchant_id: merchant_1.id)
      merchant_2.invoices.create(customer_id: customer.id, status: "success", merchant_id: merchant_2.id)
      merchant_2.invoices.create(customer_id: customer.id, status: "fail", merchant_id: merchant_2.id)
      
      get "/api/v1/merchants/#{merchant_1.id}/invoices"
      
      json_merchant_invoices = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(json_merchant_invoices.count).to eq(3)
    end
  end
end