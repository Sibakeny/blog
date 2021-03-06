# frozen_string_literal: true

class Article < ApplicationRecord
  TILE_PAGE_SIZE = 8
  LIST_PAGE_SIZE = 20

  has_many :article_categories, autosave: true
  has_many :categories, through: :article_categories
  has_many :article_view_counters
  has_many :qiita_stats, dependent: :destroy
  has_many_attached :images
  has_one_attached :thumbnail

  extend FriendlyId
  friendly_id :title, use: :slugged

  accepts_nested_attributes_for :article_categories

  # TODO: 実装
  validates :title, presence: true, if: :published?
  validates :body, presence: true, if: :published?

  scope :published_articles, -> { where(is_draft: false) }
  scope :by_query, ->(query) { where('title LIKE ?', "%#{query}%") }

  # リサイズしたサムネイル画像
  def optimized_thumbnail(x, y)
    thumbnail.variant(resize_to_fill: [x, y]).processed
  end

  # 下書きではないこと
  def published?
    !is_draft
  end

  # 記事のpvのカウント
  def count_pv
    ArticleViewCounter.create(article_id: id)
  end

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
    qiita_stats.max_by(&:created_at)&.like_count
  end

  # qiitaのpv数
  def qiita_pv
    qiita_stats.max_by(&:created_at)&.page_view_count
  end

  # 関連する記事(5件)
  def related_articles
    category_ids = categories.pluck(:id)
    Article.populate_articles.joins(:categories).where('categories.id IN (?)', category_ids).limit(5)
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
    Article.select('articles.*, count(article_view_counters.id) pv')
           .left_joins(:article_view_counters)
           .group('articles.id').order('pv desc').limit(10)
  end

  # Qiitaのpv数の多い記事を10件取得
  def self.qiita_populate_articles
    Article.select('articles.*, max(qiita_stats.page_view_count) pv')
           .left_joins(:qiita_stats).group('articles.id').order('pv desc').limit(10)
  end

  # チャート表示用に日付ごとのarticle_view_counterの数を返す
  def self.chart_values_by_date
    Article.select("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d') as time, count(*) as sum")
           .joins(:article_view_counters).group("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d')")
           .order('time asc').limit(30)
  end

  # チャート表示用に日付ごとのqiita_article_view_counterの数を返す
  def self.qiita_chart_values_by_date
    QiitaStat.all.group(' date_format(created_at, "%Y-%m-%d")').select('sum(page_view_count) sum, date_format(created_at, "%Y-%m-%d") time')
  end

  # FriendlyIdの日本語化対応のために追加
  def normalize_friendly_id(value)
    slugstr =  value
    slugstr =  slugstr.gsub(/\s+/, '-').downcase
    slugstr =  slugstr.gsub(%r{[:/?#\[\]@!$&'()\*\+,;=<>\%{}|^\\~\.\"`_]}, '-')
    slugstr = slugstr[0..70]
    slugstr
  end

  # FriendlyIdの日本語化対応のために追加
  private def should_generate_new_friendly_id? # will change the slug if the name changed
    id.present? && (slug.blank? || title_changed?)
  end

  # FriendlyIdの日本語化対応のために追加
  private def create_slug
    return unless friendly_id
    return if slugs.first.try(:slug) == friendly_id

    # Allow reversion back to a previously used slug
    relation = slugs.where(slug: friendly_id)
    relation = relation.where(scope: serialized_scope) if friendly_id_config.uses?(:scoped)
    relation.delete_all if relation.present?

    new_slug = FriendlyId::Slug.new(
      sluggable_id: id,
      sluggable_type: self.class.name.to_s,
      slug: friendly_id
    )

    new_slug.scope = serialized_scope if friendly_id_config.uses?(:scoped)
    new_slug.save
  end
end
