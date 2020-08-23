# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :article_categories, autosave: true
  has_many :categories, through: :article_categories
  has_many :article_view_counters
  has_many_attached :images

  accepts_nested_attributes_for :article_categories

  validates :title, presence: true
  validates :body, presence: true

  # チャート用の記事のPV数を返す
  def article_chart_values_by_date
    Article.select("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d') as time, count(*) as sum")
           .joins(:article_view_counters).group("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d')")
           .where('articles.id = ?', id)
           .order('time asc').limit(30)
  end

  # 記事のpv数を返す
  def pv
    article_view_counters.length
  end

  # pv数の多い記事を10件取得
  def self.populate_articles
    Article.select('articles.*, count(article_view_counters.id) pv')
           .left_joins(:article_view_counters).group('articles.id').order('pv desc').limit(10)
  end

  def self.filter(filter_params)
    all.left_joins(:categories).where(keyword_filter(filter_params)).where(category_filter(filter_params))
  end

  def self.keyword_filter(filter_params)
    return nil if filter_params[:keyword].blank?

    keyword = '%' + filter_params[:keyword] + '%'
    ['body LIKE ? OR title LIKE ?', keyword, keyword]
  end

  def self.category_filter(filter_params)
    return nil if filter_params[:category].blank?

    ['categories.name LIKE ?', filter_params[:category]]
  end

  # チャート表示用に日付ごとのarticle_view_counterの数を返す
  def self.chart_values_by_date
    Article.select("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d') as time, count(*) as sum")
           .joins(:article_view_counters).group("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d')")
           .order('time asc').limit(30)
  end
end
