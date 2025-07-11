class CreateProductMetas < ActiveRecord::Migration[8.0]
  def change
    create_table :product_metas do |t|
      t.references :product, null: false, foreign_key: true, index: true
      t.string :key, null: false
      t.text :value

      t.timestamps
    end

    add_index :product_metas, [:product_id, :key], unique: true
  end
end
