class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :sku
      t.integer :stock_quantity
      t.integer :parent_id, index: true
      t.references :category, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
