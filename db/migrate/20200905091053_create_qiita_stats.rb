class CreateQiitaStats < ActiveRecord::Migration[6.0]
  def change
    create_table :qiita_stats do |t|
      t.references :article, foreign_key: true, index: true
      t.integer :page_view_count
      t.integer :like_count
      t.timestamps
    end
  end
end
