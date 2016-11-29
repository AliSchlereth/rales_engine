class AddUnitPriceToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :unit_price, :integer
  end
end
