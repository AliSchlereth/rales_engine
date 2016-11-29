require 'rails_helper'

describe "items endpoints" do
  context 'GET /items' do
    it "returns a list of all items" do
      create_list(:item, 3)
      
      get "/api/v1/items"
      
      items = JSON.parse(response.body)
      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
  
  context 'GET /items/:id' do
    it "returns a specific item" do
      item = create(:item, name: "awesome")
      
      get "/api/v1/items/#{item.id}"
      
      show_item = JSON.parse(response.body)
      expect(response).to be_success
      expect(show_item["name"]).to eq("awesome")
    end
  end
  
  context 'GET /items/find' do
    it "returns the right item for name" do
      item_1 = create(:item, name: "best")
      item_2 = create(:item, name: "worst")
    
      get "/api/v1/items/find?name=worst"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["name"]).to eq("worst")
      expect(result["id"]).to_not eq(item_1.id)
    end
    
    it "returns the right item for description" do
      item_1 = create(:item, description: "coffee is extremely good")
      item_2 = create(:item, description: "coffee is extremely bad")
      
      get "/api/v1/items/find?description=#{item_1.description}"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["description"]).to eq("#{item_1.description}")
      expect(result["id"]).to_not eq(item_2.id)
    end
    
    it "returns the right item for merchant_id" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      
      get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"
    
      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result["merchant_id"]).to eq("#{merchant_1.id}".to_i)
      expect(result["id"]).to_not eq(item_2.id)
    end
    
    xit "returns the right item for created_at" do
      item_1 = create(:item)
      item_2 = create(:item)
      
      get "/api/v1/items/find?created_at=#{item_1.created_at.strftime("%a, %-d %b %Y %H:%M:%S UTC +00:00")}"
      result = JSON.parse(response.body)
      binding.pry
      
      expect(response).to be_success
      expect(result["created_at"]).to eq("#{item_1.created_at}")
      expect(result["id"]).to_not eq(item_2.id)
    end
    
    it "returns the all items for customer_id" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant_id: "#{merchant_1.id}")
      item_2 = create(:item, merchant_id: "#{merchant_1.id}")
      item_3 = create(:item, merchant_id: "#{merchant_1.id}")
      item_3 = create(:item, merchant_id: "#{merchant_2.id}")
      
      get "/api/v1/items/find_all?merchant_id=#{merchant_1.id}"
    
      items = JSON.parse(response.body)
      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
  
  context "GET api/v1/items/random.json" do
    it "returns an item when random is queried" do
      item_1 = create(:item)
      item_2 = create(:item)
      
      get "/api/v1/items/random.json" 
      
      item = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(item["id"]).to be_truthy
    end
  end
end