class ChangeArticleBodyLength < ActiveRecord::Migration[6.0]
  def up
    change_column :articles, :body, :text, limit: 16.megabytes - 1
  end

  def down
    change_column :articles, :body, :text
  end
end
