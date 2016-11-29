require "rails_helper"

describe "merchant endpoints" do
  context "GET merchants" do
    it "returns a list of all merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end

  context "GET /merchant/:id" do
    it "returns a merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant['id']).to eq(merchant.id)
    end
  end

  context "GET merchants/find" do
    it "returns a merchant by name" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchant1.name}"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant['name']).to eq(merchant1.name)
    end

    # it "returns a merchant by created_at" do
    #   # merchant1, merchant2 = create_list(:merchant, 2)
    #   merchant1 = Merchant.create(name: "Name1")
    #   merchant2 = Merchant.create(name: "Name2")
    #   # desired_created_at = merchant1.created_at.utc.strftime(
    #   #                     "%a, %-d %b %Y %H:%M:%S UTC +%H:%M"
    #   #                     )
    #   get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
    #
    #   json_merchant = JSON.parse(response.body)
    #   binding.pry
    #   expect(response).to be_success
    #   expect(json_merchant['created_at']).to eq(merchant1.created_at)
    #
    # end
  end

  context "GET merchants/find_all" do
    it "returns all merchants by name" do
      merchant1 = Merchant.create(name: "Name")
      merchant2 = Merchant.create(name: "Name")

      get "/api/v1/merchants/find_all?name=Name"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(2)
    end
  end

  context "GET merchants/random" do
    it "returns a random merchant record" do
      merchant1 = Merchant.create(name: "Name1")
      merchant2 = Merchant.create(name: "Name2")

      get "/api/v1/merchants/random"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant['id']).to be_truthy
    end
  end
end
