# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true
  validates :category_type, presence: true

  enum category_type: { language: 0, framework: 1 }

  # カテゴリに紐づく記事のトータルPV数
  def total_pv
    articles.joins(:article_view_counters)
            .count('article_view_counters.id') +
      (articles.joins(:qiita_stats)
               .group(' date_format(qiita_stats.created_at, "%Y-%m-%d")')
               .select('sum(page_view_count) sum, date_format(qiita_stats.created_at, "%Y-%m-%d") created_at_date')
               .to_a.last&.sum || 0)
  end

  # カテゴリに紐づく記事のトータルいいね数
  def total_like
    articles.joins(:qiita_stats)
            .group(' date_format(qiita_stats.created_at, "%Y-%m-%d")')
            .select('sum(like_count) sum, date_format(qiita_stats.created_at, "%Y-%m-%d") created_at_date')
            .to_a.last&.sum || 0
  end
end
