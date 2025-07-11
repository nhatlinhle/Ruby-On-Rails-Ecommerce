class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :logo
      t.string :banner
      t.integer :order_by
      t.boolean :is_hot, default: false
      t.integer :parent_id, default: nil
      t.timestamps
    end
  end
end
