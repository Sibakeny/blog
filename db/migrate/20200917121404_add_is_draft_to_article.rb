class AddIsDraftToArticle < ActiveRecord::Migration[6.0]
  def up
    add_column :articles, :is_draft, :boolean, null: false, default: true

    Article.all.each do |article|
      article.update!(is_draft: false)
    end
  end

  def down
    remove_column :articles, :is_draft
  end
end
