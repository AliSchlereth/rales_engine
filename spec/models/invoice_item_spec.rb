require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context "validations" do
    it "is invalid without a quantity" do
      item = create(:item)
      invoice = create(:invoice)
      invoice_item = InvoiceItem.new(unit_price: 19, item_id: item.id, invoice_id: invoice.id)
      
      expect(invoice_item).to_not be_valid
    end
    
    it "is invalid without a unit_price" do
      item = create(:item)
      invoice = create(:invoice)
      invoice_item = InvoiceItem.new(quantity: 19, item_id: item.id, invoice_id: invoice.id)
      
      expect(invoice_item).to_not be_valid
    end
    
    it "is invalid without an item_id" do
      invoice = create(:invoice)
      invoice_item = InvoiceItem.new(quantity: 19, unit_price: 2000, invoice_id: invoice.id)
      
      expect(invoice_item).to_not be_valid
    end
    
    it "is invalid without an invoice_id" do
      item = create(:item)
      invoice_item = InvoiceItem.new(quantity: 19, unit_price: 2000, item_id: item.id)
      
      expect(invoice_item).to_not be_valid
    end

    
    it "is valid with a quantity and a unit_price" do
      item = create(:item)
      invoice = create(:invoice)
      invoice_item = InvoiceItem.new(quantity: 19, unit_price: 2000, item_id: item.id, invoice_id: invoice.id)
      
      expect(invoice_item).to be_valid
    end
  end
  
  context "relationships" do
    it "responds to item" do
      invoice_item = create(:invoice_item)
      
      expect(invoice_item).to respond_to(:item)
    end
    
    it "responds to invoice" do
      invoice_item = create(:invoice_item)
      
      expect(invoice_item).to respond_to(:invoice)
    end
  end
end
