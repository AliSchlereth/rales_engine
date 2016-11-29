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

  
end
