class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.text    :name
      t.text    :description
      t.references :merchant, foreign_key: true

      t.timestamps null: false
    end
  end
end
