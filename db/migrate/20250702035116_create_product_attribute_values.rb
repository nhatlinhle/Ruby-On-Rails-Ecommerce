class CreateProductAttributeValues < ActiveRecord::Migration[8.0]
  def change
    create_table :product_attribute_values do |t|
      t.references :product, null: false, foreign_key: true
      t.references :attribute, null: false, foreign_key: true
      t.references :attribute_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
