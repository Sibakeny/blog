class ArticleViewCounters::ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    @chart_values = @article.article_chart_values_by_date
  end
end
