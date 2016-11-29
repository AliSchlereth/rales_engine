require 'csv'

desc "Import data files"
task :import => [:environment] do

  customer_file = "db/data/customers.csv"
  invoice_items_file = "db/data/invoice_items.csv"
  invoice_file = "db/data/invoices.csv"
  items_file = "db/data/items.csv"
  merchants_file = "db/data/merchants.csv"
  transaction_file = "db/data/transactions.csv"

  CSV.foreach(customer_file, :headers => true) do |row|
      Customer.first_or_create ({
        first_name: row[1],
        last_name: row[2]
      })
  end

  # CSV.foreach(items_file)

  CSV.foreach(invoice_items_file, :headers => true) do |row|
    InvoiceItem.first_or_create ({
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: row[4],
      created_at: row[5],
      updated_at: row[6]
    })
  end


end
