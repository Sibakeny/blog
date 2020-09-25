# frozen_string_literal: true

class Admin::ArticleViewCountersController < Admin::Base
  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'アクセスログ'

  def index
    @article_chart_values = Article.chart_values_by_date.map { |value| [value.time, value.sum] }
    @qiita_chart_values = Article.qiita_chart_values_by_date.map { |value| [value.time, value.sum] }
    @popular_articles = Article.populate_articles.includes(:qiita_stats).includes(:article_view_counters)
    @site_popular_articles = Article.site_populate_articles.includes(:article_view_counters)
    @qiita_popular_articles = Article.qiita_populate_articles.includes(:qiita_stats).includes(:article_view_counters)
  end
end
