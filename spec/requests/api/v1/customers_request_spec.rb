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
end
