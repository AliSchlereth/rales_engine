require 'rails_helper'

describe "single merchant business intelligence endpoints" do
  before :each do
    @merchant = create(:merchant)
    item1 = create(:item, merchant_id: @merchant.id)
    item2 = create(:item, merchant_id: @merchant.id)
    item3 = create(:item, merchant_id: @merchant.id)
    item4 = create(:item, merchant_id: @merchant.id)
    invoice1 = create(:invoice, merchant_id: @merchant.id)
    invoice2 = create(:invoice, merchant_id: @merchant.id)
    invoice3 = create(:invoice, merchant_id: @merchant.id)
    invoice4 = create(:invoice, merchant_id: @merchant.id)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction = create(:transaction, result: "failed", invoice_id: invoice2.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice3.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice4.id)
  end
  
  it "returns the total revenue for that merchant across all transactions" do
    get "/api/v1/merchants/#{@merchant.id}/revenue"
    
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["revenue"]).to eq("4.00")
  end

end