class CreateAttributeValues < ActiveRecord::Migration[8.0]
  def change
    create_table :attribute_values do |t|
      t.references :attribute, null: false, foreign_key: true
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
