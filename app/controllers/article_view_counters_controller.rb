# frozen_string_literal: true

class ArticleViewCountersController < ApplicationController
  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'アクセスログ'

  def index
    @chart_values = Article.chart_values_by_date
    @popular_articles = Article.populate_articles
  end
end
