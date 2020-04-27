# frozen_string_literal: true

class CreateArticleViewCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :article_view_counters do |t|
      t.integer :count, null: false, default: 0
      t.references :article, index: true
      t.timestamps
    end
  end
end
