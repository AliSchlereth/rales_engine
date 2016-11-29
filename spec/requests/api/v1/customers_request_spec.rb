require "rails_helper"

describe "customer endpoints" do
  context "GET /customers" do
    it "returns all customers" do
      create_list(:customer, 3)

      get "/api/v1/customers"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  context "GET customers/:id" do
    it "returns a single customer" do
      customer1, customer2 = create_list(:customer, 2)

      get "/api/v1/customers/#{customer1.id}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result['id']).to eq(customer1.id) 
    end
  end
end
