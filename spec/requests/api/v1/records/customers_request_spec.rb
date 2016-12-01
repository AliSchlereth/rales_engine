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

  context "Get customer/find" do
    it "returns a customer by first name" do
      customer1, customer2 = create_list(:customer, 2)

      get "/api/v1/customers/find?first_name=#{customer1.first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['first_name']).to eq(customer1.first_name)
    end
  end

  context "GET customers/find_all" do
    it "returns all customers by search parameter case insensitive" do
      customer1 = Customer.create(first_name: "Sue", last_name: "Jones")
      customer2 = Customer.create(first_name: "Sue", last_name: "Smith")


      get "/api/v1/customers/find_all?first_name=sue"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
    end
  end

  context "Get customers/random" do
    it "returns a random customer" do
      create_list(:customer, 2)

      get "/api/v1/customers/random"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to be_truthy
    end
  end
end
