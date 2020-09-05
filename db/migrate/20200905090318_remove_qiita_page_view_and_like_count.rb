class RemoveQiitaPageViewAndLikeCount < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :qiita_page_view_count, :integer
    remove_column :articles, :qiita_like_count, :integer
  end
end
