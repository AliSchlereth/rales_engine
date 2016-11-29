require 'rails_helper'

describe "GET /api/v1/merchants/:id/items" do
  context "a single merchant's items" do
    it "returns only the items that belong to one merchant" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_1.items.create(name: "Hat", description: "Good", unit_price: 17000)
      merchant_1.items.create(name: "Cat", description: "Gooder", unit_price: 19)
      merchant_1.items.create(name: "Mat", description: "Great", unit_price: 1)
      merchant_2.items.create(name: "Splat", description: "Awful", unit_price: 1433)
      merchant_2.items.create(name: "Bat", description: "Worse", unit_price: 1231)
      
      get "/api/v1/merchants/#{merchant_1.id}/items"
      
      json_merchant_items = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(json_merchant_items.count).to eq(3)
    end
  end
end