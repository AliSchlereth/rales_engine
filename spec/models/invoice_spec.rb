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

end
