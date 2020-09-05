# frozen_string_literal: true

class ArticleViewCountersController < ApplicationController
  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'アクセスログ'

  def index
    @article_chart_values = Article.chart_values_by_date.map { |value| [value.time, value.sum] }
    @qiita_chart_values = Article.qiita_chart_values_by_date.map { |value| [value.time, value.sum] }
    @popular_articles = Article.populate_articles
  end
end
