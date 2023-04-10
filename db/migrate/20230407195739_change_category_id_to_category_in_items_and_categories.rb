class ChangeCategoryIdToCategoryInItemsAndCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :category_id, :category
    change_column :items, :category, :string
  end
end
