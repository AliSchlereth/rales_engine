require 'rails_helper'

describe "invoice_items endpoints" do
  context 'GET /invoice_items' do
    it "returns a list of all invoice_items" do
      create_list(:invoice_item, 3)
      
      get "/api/v1/invoice_items"
      
      invoice_items = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end
  
  context 'GET /invoice_items/:id' do
    it "returns a specific invoice_item" do
      invoice_item = create(:invoice_item, quantity: 17)
      
      get "/api/v1/invoice_items/#{invoice_item.id}"
      
      show_invoice_item = JSON.parse(response.body)
      expect(response).to be_success
      expect(show_invoice_item["quantity"]).to eq(17)
    end
  end
  
  context 'GET /invoice_items/find' do
    it "returns the right invoice_item for quantity" do
      invoice_item_1 = create(:invoice_item, quantity: 98)
      invoice_item_2 = create(:invoice_item, quantity: 7)
    
      get "/api/v1/invoice_items/find?quantity=7"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["quantity"]).to eq(7)
      expect(result["id"]).to_not eq(invoice_item_1.id)
    end
    
    it "returns the right invoice_item for invoice_id" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_item_1 = create(:invoice_item, invoice_id: "#{invoice_1.id}")
      invoice_item_2 = create(:invoice_item, invoice_id: "#{invoice_2.id}")
      
      get "/api/v1/invoice_items/find?invoice_id=#{invoice_1.id}"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["invoice_id"]).to eq("#{invoice_1.id}".to_i)
      expect(result["id"]).to_not eq(invoice_item_2.id)
    end
    
    xit "returns the right invoice_item for created_at" do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      
      get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at.strftime("%a, %-d %b %Y %H:%M:%S UTC +00:00")}"
      result = JSON.parse(response.body)
      binding.pry
      
      expect(response).to be_success
      expect(result["created_at"]).to eq("#{invoice_item_1.created_at}")
      expect(result["id"]).to_not eq(invoice_item_2.id)
    end
    
    it "returns the all invoice_items for item_id" do
      item_1 = create(:item)
      item_2 = create(:item)
      invoice_item_1 = create(:invoice_item, item_id: "#{item_1.id}")
      invoice_item_2 = create(:invoice_item, item_id: "#{item_1.id}")
      invoice_item_3 = create(:invoice_item, item_id: "#{item_1.id}")
      
      get "/api/v1/invoice_items/find_all?item_id=#{item_1.id}"
    
      invoice_items = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end
  
  context "GET api/v1/invoice_items/random.json" do
    xit "returns an invoice_item when random is queried" do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      
      get "/api/v1/invoice_items/random.json" 
      
      invoice_item = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(invoice_item["status"]).to be_truthy
    end
  end
end