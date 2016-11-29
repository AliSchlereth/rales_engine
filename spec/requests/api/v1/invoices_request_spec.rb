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
  
  context 'GET /invoices/find' do
    it "returns the right invoice for status" do
      invoice_1 = create(:invoice, status: "success")
      invoice_2 = create(:invoice, status: "fail")
    
      get "/api/v1/invoices/find?status=fail"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["status"]).to eq("fail")
      expect(result["id"]).to_not eq(invoice_1.id)
    end
    
    it "returns the right invoice for customer_id" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      invoice_1 = create(:invoice, customer_id: "#{customer_1.id}")
      invoice_2 = create(:invoice, customer_id: "#{customer_2.id}")
      
      get "/api/v1/invoices/find?customer_id=#{customer_1.id}"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["customer_id"]).to eq("#{customer_1.id}".to_i)
      expect(result["id"]).to_not eq(invoice_2.id)
    end
    
    it "returns the right invoice for created_at" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      
      get "/api/v1/invoices/find?created_at=#{invoice_1.created_at.strftime("%a, %-d %b %Y %H:%M:%S UTC +00:00")}"
      result = JSON.parse(response.body)
      binding.pry
      
      expect(response).to be_success
      expect(result["created_at"]).to eq("#{invoice_1.created_at}")
      expect(result["id"]).to_not eq(invoice_2.id)
    end
  end
end