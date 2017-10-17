class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.string :name, :null => false
      t.string :image
      t.integer :price
      t.string :purchase_date
      # t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
