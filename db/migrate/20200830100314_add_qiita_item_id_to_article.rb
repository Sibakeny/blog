class AddQiitaItemIdToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :qiita_item_id, :string
  end
end
