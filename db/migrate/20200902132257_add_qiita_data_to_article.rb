class AddQiitaDataToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :qiita_page_view_count, :integer
    add_column :articles, :qiita_like_count, :integer
  end
end
