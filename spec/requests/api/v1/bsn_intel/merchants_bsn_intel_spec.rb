require 'rails_helper'

describe "GET /api/v1/merchants/most_revenue?quantity=x" do
  it "returns the top x merchants ranked by total revenue" do
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

    get "/api/v1/merchants/most_revenue?quantity=3"

    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
  end
end
