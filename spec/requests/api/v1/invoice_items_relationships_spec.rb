require 'rails_helper'

describe "GET /api/v1/invoice_items/:id/invoice" do
  it "returns an invoice for an invoice item" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = InvoiceItem.create(item: item, invoice: invoice, quantity: 2, unit_price: 235)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(invoice.id)
  end
end

describe "GET /api/v1/invoice_items/:id/item" do
  it "returns an item for an invoice item" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = InvoiceItem.create(item: item, invoice: invoice, quantity: 2, unit_price: 235)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(item.id)
  end
end
