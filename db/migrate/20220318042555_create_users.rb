class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :salt
      t.string :crypted_password
      t.timestamps
    end
    add_index :toys,[:user_id]
  end
end
