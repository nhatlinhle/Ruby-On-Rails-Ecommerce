class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.string :address
      t.string :birth_day
      t.string :phone_number

      t.timestamps
    end
  end
end
