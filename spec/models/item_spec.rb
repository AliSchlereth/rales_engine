require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it "is invalid without a name" do
      item = Item.new(unit_price: 2, description: "Things")
      expect(item).to_not be_valid
    end

    it "is invalid without a unit price" do
      item = Item.new(name: "Name", description: "Things")
      expect(item).to_not be_valid
    end

    it "is invalid without a description" do
      item = Item.new(unit_price: 2, name: "Name")
      expect(item).to_not be_valid
    end

    it "is invalid without a merchant" do
      item = Item.new(unit_price: 2, name: "Name", description: "Things")
      expect(item).to_not be_valid
    end


    it "is valid with a name, unit price, and description" do
      merchant = create(:merchant)
      item = Item.create(unit_price: 2, description: "Things", name: "Name", merchant: merchant)
      expect(item).to be_valid
    end
  end

  context "relationships" do
    it "responds to invoice items" do
      item = Item.new(unit_price: 2, description: "Things", name: "Name")
      expect(item).to respond_to(:invoice_items)
    end

    it "responds to invoice items" do
      item = Item.new(unit_price: 2, description: "Things", name: "Name")
      expect(item).to respond_to(:invoices)
    end
  end

end
