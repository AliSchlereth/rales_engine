# Rales Engine

A Sales Engine API for gathering and analyzing sales data built with Rails.

[![Code Climate](https://codeclimate.com/github/AliSchlereth/rales_engine/badges/gpa.svg)](https://codeclimate.com/github/AliSchlereth/rales_engine)

# How to install

### First: 
Pick your favorite directory, then:

`git clone https://github.com/AliSchlereth/rales_engine.git`

`cd rales_engine`

### Second: 
Run `bundle`. You'll need to be using Ruby 2.3.0. If you don't have that, 
and you have rvm installed, you can run:

`rvm install ruby-2.3.0` ... to get 2.3.0. 

The Gemfile should automatically switch rubies for you when you open Rales Engine

but if not, you can do `rvm use 2.3.0`.

### Third:
Check inside the `db/data` directory and make sure you have the following

CSV files: `customers.csv, invoice_items.csv, invoices.csv, items.csv, merchants.csv,
transactions.csv`. If you don't, something has gone weird and you'll need to clone down

`git clone https://github.com/turingschool-examples/sales_engine` and copy the CSV

from that repo's data directory.

Cool.

### Fourth:
Now, you'll need to make sure your PostgreSQL database is running. If you've got

a small elephant at the top of your screen: great. If not, spin up your PostgreSQL app.

(If you don't have the app, go [here](http://postgresapp.com/) and follow the install instructions.)

### Fifth:
Next: run the following command in your terminal:

`rake db:create db:migrate db:test:prepare`

Things will become briefly extremely exciting, then extremely calm.

### Sixth: 
You're not done yet. Run `rake import` to pull all of the CSV files into the database.

This will take some time, and you won't know it's done until you are returned to your terminal prompt.

While you wait you can hum a little song, or read some of that book, or go to [this page](https://github.com/turingschool/rales_engine_spec_harness) and clone down the spec harness.

It's not strictly necessary for running Rales Engine but it'll help you put it through its paces.

### Seventh: 

Okay, all finished with `rake import`? Go ahead and run `rspec` - make sure all the

tests pass. If not, you might be missing a gem or maybe you should go back and run

`rake db:test:prepare`. 

### Endpoints  
### Record Endpoints 
* `GET /api/v1/merchants/`
* `GET /api/v1/merchants/:id`
* `GET /api/v1/invoices/`
* `GET /api/v1/invoices/:id`
* `GET /api/v1/invoice_items/`
* `GET /api/v1/invoice_items/:id`
* `GET /api/v1/items/`
* `GET /api/v1/items/:id`
* `GET /api/v1/transactions/`
* `GET /api/v1/transactions/:id`
* `GET /api/v1/customers/`
* `GET /api/v1/customers/:id`

### Relationship Endpoints
#### Merchants

* `GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant
* `GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices

* `GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions
* `GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/invoices/:id/items` returns a collection of associated items
* `GET /api/v1/invoices/:id/customer` returns the associated customer
* `GET /api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items

* `GET /api/v1/invoice_items/:id/invoice` returns the associated invoice
* `GET /api/v1/invoice_items/:id/item` returns the associated item

#### Items

* `GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/items/:id/merchant` returns the associated merchant

#### Transactions

* `GET /api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers

* `GET /api/v1/customers/:id/invoices` returns a collection of associated invoices
* `GET /api/v1/customers/:id/transactions` returns a collection of associated transactions 

### Business Intelligence Endpoints
#### All Merchants

* `GET /api/v1/merchants/most_revenue?quantity=x` returns the top `x` merchants ranked by total revenue
* `GET /api/v1/merchants/most_items?quantity=x` returns the top `x` merchants ranked by total number of items sold
* `GET /api/v1/merchants/revenue?date=x` returns the total revenue for date `x` across all merchants. Assume the dates provided match the format of a standard ActiveRecord timestamp.

#### Single Merchant

* `GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across successful transactions
* `GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date `x`
* `GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.  
*`GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of `success`.

#### Items

* `GET /api/v1/items/most_revenue?quantity=x` returns the top `x` items ranked by total revenue generated
* `GET /api/v1/items/most_items?quantity=x` returns the top `x` item instances ranked by total number sold
* `GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

#### Customers

* `GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions

### Extra steps:

If you downloaded the test harness, you can test it out by `cd`'ing into it and

running `bundle`, then go back to your rales_engine directory in your terminal and run `rails s`

to start the server. Great. Now go back to the harness directory and run `rake`.

Enjoy all the pretty colors.

## Technical details:

A Rails API storing a large amount of data in a PostgreSQL database. Tests written
in rspec-rails, with dummy items coming from factory girl. Coverage provided by 
simplecov.






