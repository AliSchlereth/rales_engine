require 'csv'

desc "Import data files"
task :import => [:environment] do

  customer_file = "db/data/customers.csv"
  merchant_file = "db/data/merchants.csv"
  item_file = "db/data/items.csv"
  invoice_file = "db/data/invoices.csv"
  invoice_items_file = "db/data/invoice_items.csv"
  transaction_file = "db/data/transactions.csv"

  CSV.foreach(customer_file, :headers => true) do |row|
      Customer.create({
        first_name: row[1],
        last_name: row[2]
      })
  end

  CSV.foreach(merchant_file, :headers => true) do |row|
    Merchant.create({
      name: row[1],
      created_at: row[2],
      updated_at: row[3]
      })
  end

  CSV.foreach(item_file, :headers => true) do |row|
    Item.create({
      name: row[1],
      description: row[2],
      unit_price: row[3],
      merchant_id: row[4],
      created_at: row[5],
      updated_at: row[6]
      })
  end

  CSV.foreach(invoice_file, :headers => true) do |row|
    Invoice.create({
      customer_id: row[1],
      merchant_id: row[2],
      status: row[3],
      created_at: row[4],
      updated_at: row[5]
      })
  end

  CSV.foreach(invoice_items_file, :headers => true) do |row|
    InvoiceItem.create({
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: row[4],
      created_at: row[5],
      updated_at: row[6]
    })
  end

  CSV.foreach(transaction_file, :headers => true) do |row|
    Transaction.create({
      invoice_id: row[1],
      credit_card_number: row[2],
      result: row[4],
      created_at: row[5],
      updated_at: row[6]
      })
  end

end
