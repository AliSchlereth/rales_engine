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

  context "GET merchant/find" do
    it "returns a merchant by name" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchant1.name}"

      json_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_merchant['name']).to eq(merchant1.name)
    end
  end
end
