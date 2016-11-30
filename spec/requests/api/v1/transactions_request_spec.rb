require "rails_helper"

describe "GET /transactions" do
  it "returns all transactions" do
    create_list(:transaction, 2)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(2)
  end

  it "returns one transaction" do
    trans1, trans2 = create_list(:transaction, 2)

    get "/api/v1/transactions/#{trans1.id}"

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['id']).to eq(trans1.id)
  end

  context "returns by search parameters" do
    it "returns a transaction by credit_card_number" do
      trans1, trans2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find?credit_card_number=#{trans1.credit_card_number}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result['credit_card_number']).to eq(trans1.credit_card_number.to_s)
    end

    it "returns all results by criteria" do
      invoice = create(:invoice)
      trans1 = Transaction.create(credit_card_number: 1234, result: "fail", invoice_id: invoice.id)
      trans2 = Transaction.create(credit_card_number: 1234, result: "success", invoice_id: invoice.id)


      get "/api/v1/transactions/find_all?credit_card_number=1234"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(2)
    end
  end

  context "GET /transactions/random" do
    it "returns a single transaction" do
      trans1, trans2 = create_list(:transaction, 2)

      get "/api/v1/transactions/random"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result['id']).to be_truthy
    end
  end
end
