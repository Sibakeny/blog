# frozen_string_literal: true

class ArticleViewCounters::ArticlesController < ApplicationController
  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'アクセスログ', :article_view_counters_path

  def show
    add_breadcrumb '記事のアクセスログ'
    @article = Article.find(params[:id])
    @article_chart_value = @article.article_chart_values_by_date.map { |value| [value.time, value.sum] }
    @qiita_chart_values = @article.qiita_chart_values_by_date.map { |value| [value.time, value.sum] }
  end
end
