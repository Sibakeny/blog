# frozen_string_literal: true

class ArticleViewCountersController < ApplicationController
  def index
    add_breadcrumb 'HOME', root_path
    add_breadcrumb 'アクセスログ'
    @chart_values = Article.chart_values_by_date
    @popular_articles = Article.select('articles.*, count(article_view_counters.id) pv')
                               .left_joins(:article_view_counters).group('articles.id').order('pv desc').limit(10)

    # @soaring_articles =
  end
end
