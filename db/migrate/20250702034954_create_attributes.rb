class CreateAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :attributes do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
