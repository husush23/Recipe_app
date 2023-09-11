class CreateFood < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit
      t.integer :user_id
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
    add_foreign_key :foods, :users, column: :user_id
    add_index :foods, :user_id
  end
end
