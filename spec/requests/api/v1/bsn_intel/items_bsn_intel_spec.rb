require "rails_helper"

describe "items business intelligence" do
  before :each do
    @item1, @item2, @item3 = create_list(:item, 3)
    invoice1, invoice2, invoice3 = create_list(:invoice, 3)
    invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: invoice3.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction3 = create(:transaction, invoice_id: invoice2.id, result: "success")
    transaction4 = create(:transaction, invoice_id: invoice3.id, result: "failed")


  end

  it "returns the top x items ranked by total revenue generated" do

    get "/api/v1/items/most_revenue?quantity=2"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end

  it "returns the top x item instances ranked by total number sold" do
    get "/api/v1/items/most_items?quantity=2"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
  end

  it "returns the date with the most sales for the given item using the invoice date" do
    get "/api/v1/items/#{@item1.id}/best_day"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(1)
  end
end
