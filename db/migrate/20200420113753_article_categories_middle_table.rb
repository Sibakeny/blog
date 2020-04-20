class ArticleCategoriesMiddleTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :article_categories, :category_type, :integer
    remove_column :article_categories, :name, :string
    add_reference :article_categories, :category
  end
end
