class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :credt_card_number
      t.string :result
      t.references :invoice, foreign_key: true

      t.timestamps null: false
    end
  end
end
