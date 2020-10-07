class ChangeHeaderToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :header, :text
  end
end
