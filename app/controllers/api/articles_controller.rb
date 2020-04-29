# frozen_string_literal: true

class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:categories, :article_view_counters).all

    @articles = @articles.where('body LIKE ?', '%' + params[:keyword] + '%') if params[:keyword].present?

    if params[:category].present?
      @articles = @articles.joins(:categories).where('categories.name LIKE ?', params[:category])
    end

    article_ids = @articles.pluck(:id)
    @articles = Article.includes(:categories, :article_view_counters).where(id: article_ids)
    @articles = if params[:order_type] == 'view_count'
                  @articles.joins(:article_view_counters).order('article_view_counters.count desc')

                else
                  @articles.order(created_at: :desc)
                end

    @articles = @articles.page(params[:page]).per(8)
    count = @articles.total_pages
    render json: { articles: ActiveModelSerializers::SerializableResource.new(@articles).as_json, count: count }
  end

  def show
    @article = Article.find(params[:id])
    @article_view_counter = ArticleViewCounter.create(article_id: @article.id)
    render json: @article
  end
end
