class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
    	# 全てに対してNULLを不許可
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.string :token, :null => false

      t.timestamps
    end
  end
end
