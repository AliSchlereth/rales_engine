require "rails_helper"

describe "GET /api/v1/items/:id/invoice_items" do
  it "returns invoice items for an item" do
    item1, item2 = create_list(:item, 2)
    invoice = create(:invoice)
    item1.invoice_items.create(invoice: invoice, quantity: 2, unit_price: 345)
    item1.invoice_items.create(invoice: invoice, quantity: 4, unit_price: 555)

    get "/api/v1/items/#{item1.id}/invoice_items"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end

end

describe "GET GET /api/v1/items/:id/merchant" do
  it "returns merchants for an item" do
    merchant = create(:merchant)
    item = Item.create(name: "Name", description: "Thing", unit_price: 234, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(merchant.id)
  end

end
