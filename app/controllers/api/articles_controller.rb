# frozen_string_literal: true

class Api::ArticlesController < Api::ApplicationController
  def index
    articles = Article.filter(params)
    article_ids = articles.pluck(:id)
    p params
    p ArticleViewCounter.all

    articles = Article.includes(:categories, :article_view_counters).where(id: article_ids).flex_sort(params)
    articles = articles.page(params[:page]).per(8)
    p articles
    count = articles.total_pages
    render status: 200, json: {
      articles: ActiveModelSerializers::SerializableResource.new(articles).as_json,
      count: count
    }
  end

  def show
    @article = Article.find(params[:id])
    @article_view_counter = ArticleViewCounter.create(article_id: @article.id)
    render json: @article
  end
end
