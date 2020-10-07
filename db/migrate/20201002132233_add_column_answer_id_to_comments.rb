class AddColumnAnswerIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :answer_id, :string
    add_index :comments, :answer_id
  end
end
