# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :article_view_counters
  accepts_nested_attributes_for :article_categories

  validates :title, presence: true
  validates :body, presence: true

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

  def self.flex_sort(params)
    if params[:order_type] == 'view_count'
      joins(:article_view_counters).order('article_view_counters.count desc')
    else
      order(created_at: :desc)
    end
  end
end
