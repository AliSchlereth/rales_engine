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

end
