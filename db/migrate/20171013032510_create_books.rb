class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :user
      t.string :name, null: false
      t.string :image
      t.integer :price
      t.date :purchase_date

      t.timestamps
    end
  end
end
