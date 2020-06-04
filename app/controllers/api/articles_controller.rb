# frozen_string_literal: true

class Api::ArticlesController < Api::ApplicationController
  def index
    articles = Article.filter(params)
    article_ids = articles.pluck(:id)

    if params[:order_type] == 'view_count'
      articles = Article.select('articles.*, count(article_view_counters.id) pv')
                        .left_joins(:article_view_counters).group('articles.id').where(id: article_ids).order('pv desc')
    else
      articles = Article.includes(:categories, :article_view_counters).where(id: article_ids).order('created_at desc')
    end
    articles = articles.page(params[:page]).per(8)

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
