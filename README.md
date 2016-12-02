# Rales Engine

Rales Engine! It's like a Sales Engine, but with Rails!

This is a handy little API for gathering and analyzing sales data. 

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

### Extra steps:

If you downloaded the test harness, you can test it out by `cd`'ing into it and

running `bundle`, then go back to your rales_engine directory in your terminal and run `rails s`

to start the server. Great. Now go back to the harness directory and run `rake`.

Enjoy all the pretty colors.

## Technical details:

A Rails API storing a large amount of data in a PostgreSQL database. Tests written
in rspec-rails, with dummy items coming from factory girl. Coverage provided by 
simplecov.






