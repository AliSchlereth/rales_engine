require 'rails_helper'

RSpec.describe Invoice, type: :model do
	
	context "validations" do
  it "is invalid without a status" do
		merchant = create(:merchant)
		customer = create(:customer)
		invoice = Invoice.new(customer_id: 1, merchant_id: 1)

		expect(invoice).to_not be_valid
	 end
		
	it "is invalid	without a customer_id" do
		merchant = create(:merchant)
		customer = create(:customer)
		invoice = Invoice.new(status: "success", merchant_id: 1)
		
		expect(invoice).to_not be_valid
	end

	it "is invalid without a merchant_id" do
		merchant = create(:merchant)
		customer = create(:customer)
		invoice = Invoice.new(status: "success", customer_id:1)

		expect(invoice).to_not be_valid
	end	

	it "is valid with all necessary info" do
		merchant = create(:merchant)
		customer = create(:customer)
		invoice = Invoice.new(status: "success", merchant_id: merchant.id, customer_id: customer.id)

		expect(invoice).to be_valid
	 end
	end
	
	context "relationships" do
		it "responds to customers" do
			invoice = create(:invoice)
			
			expect(invoice).to respond_to(:customer)
		end
		
		it "responds to merchants" do
			invoice = create(:invoice)
			
			expect(invoice).to respond_to(:merchant)
		end
		
		it "responds to invoice items" do
			invoice = create(:invoice)
			
			expect(invoice).to respond_to(:invoice_items)
		end
		
		it "responds to items" do
			invoice = create(:invoice)
			
			expect(invoice).to respond_to(:items)
		end
		
		it "responds to transactions" do
			invoice = create(:invoice)
			
			expect(invoice).to respond_to(:transactions)
		end
		
	end

end
