class ChangeToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :login, false

    add_index :users, [:email], unique: true
  end
end
