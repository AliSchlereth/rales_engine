require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "validations" do
    it "is invalid without a first name" do
      customer = Customer.new(last_name: "Allen")
      expect(customer).to_not be_valid
    end

    it "is invalid without a last name" do
      customer = Customer.new(first_name: "Matt")
      expect(customer).to_not be_valid
    end

    it "is valid with a last_name and first_name" do
      customer = Customer.new(first_name: "Susan", last_name: "Mayer")

      expect(customer).to be_valid
    end
  end

  context "relationships" do
    it "responds to has many invoices" do
      customer = Customer.new(first_name: "Susan", last_name: "Mayer")

      expect(customer).to respond_to(:invoices)
    end
  end

  context "randomizer" do
    it "only returns one random customer" do
      customer1, customer2 = create_list(:customer, 2)

      result = [Customer.customer_randomizer]
      expect(result.count).to eq(1)
    end
  end
  
  context "favorite merchant" do
    it "finds a single merchant by most transactions" do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant2.id)
      invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice1.id)
      transaction3 = create(:transaction, invoice_id: invoice2.id)

      favorite = customer.favorite_merchant
      expect(favorite).to eq(merchant1)
      expect(favorite).to_not eq(merchant2)
    end
  end

end
