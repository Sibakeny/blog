class ChangeArticleBodyLength < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :body, :text, limit: 16.megabytes - 1
  end
end
