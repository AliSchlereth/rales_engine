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

  context "randomizer" do
    it "returns a single item" do
      item1, item2 = create_list(:item, 2)

      result = [Item.item_randomizer]

      expect(result.count).to eq(1)
      expect(result[0].description).to be_truthy
    end
  end

  context "item request methods" do
    before :each do
      @item1, @item2, @item3 = create_list(:item, 3)
      @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3)
      invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
      invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id)
      invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id)
      transaction1 = create(:transaction, invoice_id: @invoice1.id, result: "success")
      transaction2 = create(:transaction, invoice_id: @invoice1.id, result: "success")
      transaction3 = create(:transaction, invoice_id: @invoice2.id, result: "success")
      transaction4 = create(:transaction, invoice_id: @invoice3.id, result: "failed")
    end

    it "returns the top 2 items ranked by total revenue generated" do
      result = Item.most_revenue(2)

      expect(result.length).to eq(2)
      expect(result[0]).to eq(@item1)
      expect(result.include?(@item3)).to be_falsey
    end

    it "returns the top 1 items ranked by total revenue generated" do
      result = Item.most_revenue(1)

      expect(result.length).to eq(1)
      expect(result[0]).to eq(@item1)
    end

    it "returns the top 2 item instances ranked by total number sold" do
      result = Item.most_items(2)

      expect(result.length).to eq(2)
      expect(result[0]).to eq(@item1)
      expect(result.include?(@item3)).to be_falsey
    end

    it "returns the date with the most sales for the given item using the invoice date" do
      result = @item1.best_day

      expect(result).to eq(@item1.invoices[0].created_at)
      expect(result).to_not eq(@item2.invoices[0].created_at)
    end
  end

end
