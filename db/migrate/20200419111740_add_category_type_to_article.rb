class AddCategoryTypeToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :article_categories, :category_type, :integer
  end
end
