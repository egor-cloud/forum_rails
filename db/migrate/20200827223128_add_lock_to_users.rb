class AddLockToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lock, "ENUM('0', '1', '2') DEFAULT '0'"
  end
end
