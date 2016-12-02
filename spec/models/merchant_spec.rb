require "rails_helper"

RSpec.describe Merchant, type: :model do
  context "validations" do
    it "is invalid without a name" do
      merchant = Merchant.new()
      expect(merchant).to_not be_valid
    end

    it "is valid with a name" do
      merchant = Merchant.new(name: "Name")
      expect(merchant).to be_valid
    end
  end

  context "relationships" do
    it "resonds to items" do
      merchant = Merchant.new(name: "Name")
      expect(merchant).to respond_to(:items)
    end

    it "responds to invoices" do
      merchant = Merchant.new(name: "Name")
      expect(merchant).to respond_to(:invoices)
    end
  end

  context "merchant randomizer" do
    it "returns a random merchant" do
      merchant1, merchant2 = create_list(:merchant, 2)

      result = [Merchant.merchant_randomizer]
      expect(result.count).to eq(1)
      expect(result[0].name).to be_truthy
    end
  end

  context "merchant bsn intel methods" do
    before :each do
      @merchant1, @merchant2, @merchant3, @merchant4 = create_list(:merchant, 4)
      item1 = create(:item, merchant_id: @merchant1.id)
      item2 = create(:item, merchant_id: @merchant1.id)
      item3 = create(:item, merchant_id: @merchant2.id)
      item4 = create(:item, merchant_id: @merchant3.id)
      invoice1 = create(:invoice, merchant_id: @merchant1.id)
      invoice2 = create(:invoice, merchant_id: @merchant1.id)
      invoice3 = create(:invoice, merchant_id: @merchant2.id)
      invoice4 = create(:invoice, merchant_id: @merchant3.id)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice3.id)
      invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction = create(:transaction, result: "failed", invoice_id: invoice2.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice3.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice4.id)
    end

    it "returns the top 2 merchants ranked by total revenue" do
      result = Merchant.most_revenue(1)

      expect(result.length).to eq(1)
      expect(result[0]).to be_a(Merchant)
    end

    it "returns the top 3 merchants ranked by total revenue" do
      result = Merchant.most_revenue(3)

      expect(result.length).to eq(3)
      expect(result.include?(@merchant4)).to be_falsey
    end

    it "returns the top 2 merchants ranked by total number of items sold" do
      result = Merchant.most_items(2)

      expect(result.length).to eq(2)
      expect(result.include?(@merchant4)).to be_falsey
    end

    it "returns the top 1 merchants ranked by total number of items sold" do
      result = Merchant.most_items(1)

      expect(result.length).to eq(1)
      expect(result[0]).to be_a(Merchant)
    end

    it "returns the total revenue for date x across all merchants in integer form" do
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

      result = Merchant.revenue_by_date(date)
      total_revenue = (invoice_item.quantity * invoice_item.unit_price) + (invoice_item2.quantity * invoice_item2.unit_price)

      expect(result).to be_a(Integer)
      expect(result).to eq(total_revenue)
    end

    it "returns the total revenue for that merchant across all transactions" do
      result = @merchant2.single_merchant_revenue

      expect(result).to be_a(Integer)
      expect(result).to eq(1)
    end

    it "returns the total revenue for a merchant across all successful transactions" do
      result = @merchant1.single_merchant_revenue

      expect(@merchant1.invoices.count).to eq(2)
      expect(result).to eq(1)
    end

    it "returns the total revenue for that merchant for a specific invoice date x as an integer" do
      date = "2012-03-27 14:56:04"

      merchant = Merchant.create(name: "Yay")
      customer = Customer.create(first_name: "Hello", last_name: "Goodbye")
      invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: date)
      item = Item.create(merchant_id: merchant.id, name: "Coffee", description: "scrumptious", unit_price: 500)
      invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 4, unit_price: 500)
      transaction = Transaction.create(credit_card_number: 4815162342, result: "success", invoice_id: invoice.id)

      result = merchant.single_merchant_revenue(date)
      revenue = invoice_item.quantity * invoice_item.unit_price

      expect(result).to be_a(Integer)
      expect(result).to eq(revenue)
    end

    it "returns the customer who has conducted the most total number of successful transactions" do
      result = [@merchant1.single_merchant_favorite_customer]

      expect(result[0]).to be_a(Customer)
      expect(result.count).to eq(1)
    end

    

  end
end
