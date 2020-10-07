class CreateJoinTableTagPost < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tags, :posts do |t|
      t.index [:tag_id, :post_id]
      t.index [:post_id, :tag_id]
    end
  end
end
