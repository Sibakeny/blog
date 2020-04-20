class AddCategoryTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :category_type, :integer
  end
end
