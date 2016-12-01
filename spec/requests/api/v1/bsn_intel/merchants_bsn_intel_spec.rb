require 'rails_helper'

describe "all merchants business intelligence endpoints" do
  before :each do
    merchant1, merchant2, merchant3, merchant4 = create_list(:merchant, 4)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant2.id)
    item4 = create(:item, merchant_id: merchant3.id)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant1.id)
    invoice3 = create(:invoice, merchant_id: merchant2.id)
    invoice4 = create(:invoice, merchant_id: merchant3.id)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction = create(:transaction, result: "failed", invoice_id: invoice2.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice3.id)
    transaction = create(:transaction, result: "success", invoice_id: invoice4.id)
  end
  it "returns the top x merchants ranked by total revenue" do

    get "/api/v1/merchants/most_revenue?quantity=3"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(3)
  end

  it "returns top x merchants ranked by total number of items sold" do
    get '/api/v1/merchants/most_items?quantity=2'

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end
  
  xit "returns the total revenue for date x across all merchants" do
    invoice_extra = create(:invoice, created_at: "2012-03-27 14:56:04")
    extra_invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 1000, created_at: "2012-03-27 14:56:04", invoice_id: invoice_extra.id)
    extra_invoice_item2 = create(:invoice_item, quantity: 2, unit_price: 1000, created_at: "2012-03-27 14:56:04", invoice_id: invoice_extra.id)
    extra_invoice_item3 = create(:invoice_item, quantity: 3, unit_price: 1000, created_at: "2012-03-27 14:56:04", invoice_id: invoice_extra.id)
    
    get '/api/v1/merchants/revenue?date=2012-03-27 14:56:04"'
    
    result = JSON.parse(response.body)
    binding.pry
    expect(response).to be_success
    expect(result["total_revenue"]).to eq("60.00")
  end

end
