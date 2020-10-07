class AddCategoryAvatarToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :avatar, :string
  end
end
