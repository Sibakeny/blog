# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :article_categories, autosave: true
  has_many :categories, through: :article_categories
  has_many :article_view_counters
  has_many :qiita_stats, dependent: :destroy
  has_many_attached :images

  accepts_nested_attributes_for :article_categories

  # TODO: 実装
  # validates :title, presence: true
  # validates :body, presence: true

  # チャート用の記事のPV数を返す
  # TODO: 一ヶ月分のデータのみ持ってくる様にする
  def article_chart_values_by_date
    article_view_counters.select("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d') as time, count(*) as sum")
                         .group("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d')")
                         .order('time asc').limit(30)
  end

  # チャート用のQiitaの記事のPV数を返す
  # TODO: 一ヶ月分のデータのみ持ってくる様にする
  def qiita_chart_values_by_date
    qiita_stats.select("DATE_FORMAT(qiita_stats.created_at, '%Y-%m-%d') as time, qiita_stats.page_view_count as sum")
               .order('time asc').limit(30)
  end

  # 記事のpv数を返す
  def pv
    article_view_counters.length
  end

  # qiitaのいいねの数
  def like_count
    qiita_stats.sort_by { |s| s.created_at }.last&.like_count
  end

  # qiitaのpv数
  def qiita_page_view
    qiita_stats.sort_by { |s| s.created_at }.last&.page_view_count
  end

  # qiitaと自分のサイトのpv数の合計が多い記事を10件取得
  def self.populate_articles
    Article.select('articles.*, count(article_view_counters.id) + max(qiita_stats.page_view_count) pv')
           .left_joins(:article_view_counters)
           .left_joins(:qiita_stats)
           .group('articles.id').order('pv desc').limit(10)
  end

  # サイトのpv数の多い記事を10件取得
  def self.site_populate_articles
    Article.select('articles.*, max(qiita_stats.page_view_count) pv')
           .left_joins(:qiita_stats).group('articles.id').order('pv desc').limit(10)
  end

  # Qiitaのpv数の多い記事を10件取得
  def self.qiita_populate_articles
    Article.select('articles.*, max(qiita_stats.page_view_count) pv')
           .left_joins(:qiita_stats).group('articles.id').order('pv desc').limit(10)
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

  # チャート表示用に日付ごとのqiita_article_view_counterの数を返す
  def self.qiita_chart_values_by_date
    Article.joins(:qiita_stats).select("DATE_FORMAT(qiita_stats.created_at, '%Y-%m-%d') as time, qiita_stats.page_view_count as sum").order('time asc').limit(30)
  end
end
