# frozen_string_literal: true

class CreateArticleCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :article_categories do |t|
      t.string :name
      t.references :article
      t.timestamps
    end
  end
end
