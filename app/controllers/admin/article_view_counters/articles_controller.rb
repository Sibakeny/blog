# frozen_string_literal: true

class Admin::ArticleViewCounters::ArticlesController < Admin::Base
  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'アクセスログ', :admin_article_view_counters_path

  def show
    add_breadcrumb '記事のアクセスログ'
    @article = Article.find(params[:id])
    @article_chart_value = @article.article_chart_values_by_date.map { |value| [value.time, value.sum] }
    @qiita_chart_values = @article.qiita_chart_values_by_date.map { |value| [value.time, value.sum] }
  end
end
