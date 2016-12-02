require 'rails_helper'

describe "single merchant business intelligence endpoints" do
  before :each do
    @merchant = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    item1 = create(:item, merchant_id: @merchant.id)
    item2 = create(:item, merchant_id: @merchant.id)
    item3 = create(:item, merchant_id: @merchant.id)
    item4 = create(:item, merchant_id: @merchant.id)
    invoice1 = create(:invoice, merchant_id: @merchant.id, customer_id: @customer_1.id)
    invoice2 = create(:invoice, merchant_id: @merchant.id, customer_id: @customer_1.id)
    invoice3 = create(:invoice, merchant_id: @merchant.id, customer_id: @customer_2.id)
    invoice4 = create(:invoice, merchant_id: @merchant.id, customer_id: @customer_2.id)
    @invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    @invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
    @invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id)
    @invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id)
    transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: "failed", invoice_id: invoice2.id)
    transaction3 = create(:transaction, result: "success", invoice_id: invoice3.id)
    transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
  end
  
  it "returns the total revenue for that merchant across all transactions" do
    get "/api/v1/merchants/#{@merchant.id}/revenue"
    
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result["revenue"]).to eq("0.03")
  end
  
  it "returns the total revenue for that merchant for a specific date" do    
    date = "2012-03-27 14:56:04"

    merchant = Merchant.create(name: "Yay")
    customer = Customer.create(first_name: "Hello", last_name: "Goodbye")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: date)
    item = Item.create(merchant_id: merchant.id, name: "Coffee", description: "scrumptious", unit_price: 500)
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 4, unit_price: 500)
    transaction = Transaction.create(credit_card_number: 4815162342, result: "success", invoice_id: invoice.id)
    
    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"
    
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result["revenue"]).to eq("20.0")
  end
  
  it "returns the customer who has conducted the most successful transactions" do
    get "/api/v1/merchants/#{@merchant.id}/favorite_customer"
    
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result["first_name"]).to eq("#{@customer_2.first_name}")
  end
  
  it "returns a collection of customers who have pending invoices" do
    failed_customer = create(:customer)
    
    get "/api/v1/merchants/#{@merchant.id}/customers_with_pending_invoices"
    
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result)
  end

end



