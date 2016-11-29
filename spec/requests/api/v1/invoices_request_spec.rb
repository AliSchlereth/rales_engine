require 'rails_helper'

describe "invoices endpoints" do
  context 'GET /invoices' do
    it "returns a list of all invoices" do
      create_list(:invoice, 3)
      
      get "/api/v1/invoices"
      
      invoices = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
  
  context 'GET /invoices/:id' do
    it "returns a specific invoice" do
      invoice = create(:invoice, status: "success")
      
      get "/api/v1/invoices/#{invoice.id}"
      
      show_invoice = JSON.parse(response.body)
      expect(response).to be_success
      expect(show_invoice["status"]).to eq("success")
  end
end
end