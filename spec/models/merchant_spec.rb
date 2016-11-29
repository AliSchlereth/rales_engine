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
end
