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
  
  it "returns the total revenue for date x across all merchants" do
    date = "2012-03-27 14:56:04"
    
    merchant = Merchant.create(name: "Yay")
    customer = Customer.create(first_name: "Hello", last_name: "Goodbye")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: date)
    item = Item.create(merchant_id: merchant.id, name: "Coffee", description: "scrumptious", unit_price: 500)
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 4, unit_price: 500)
    transaction = Transaction.create(credit_card_number: 4815162342, result: "success", invoice_id: invoice.id)
    
    merchant2 = Merchant.create(name: "Nooooo")
    customer2 = Customer.create(first_name: "Hello", last_name: "Goodbye")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant2.id, status: "shipped", created_at: date)
    item2 = Item.create(merchant_id: merchant2.id, name: "Coffee", description: "scrumptious", unit_price: 500)
    invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 4, unit_price: 500)
    transaction = Transaction.create(credit_card_number: 4815162342, result: "success", invoice_id: invoice2.id)

    get "/api/v1/merchants/revenue?date=#{date}"
    
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result["total_revenue"]).to eq("40.0")
  end

end
