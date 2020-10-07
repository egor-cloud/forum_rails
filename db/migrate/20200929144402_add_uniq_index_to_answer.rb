class AddUniqIndexToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_index :answers, [:user_id, :post_id ], :unique => true
  end
end
