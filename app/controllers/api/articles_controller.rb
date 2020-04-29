# frozen_string_literal: true

class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:categories, :article_view_counter).all
    if params[:order_type] == 'created_at'
      @articles = @articles.order(created_at: :desc)
    elsif params[:order_type] == 'view_count'
      @articles = @articles.joins(:article_view_counter).order('article_view_counters.count desc')
    end

    if params[:keyword].present?
      @articles = @articles.where('body LIKE ?', '%' + params[:keyword] + '%')
    end

    if params[:category].present?
      @articles = @articles.joins(:categories).where('categories.name LIKE ?', params[:category])
    end

    article_ids = @articles.pluck(:id)
    @articles = Article.includes(:categories, :article_view_counter).where(id: article_ids).page(params[:page]).per(8)
    count = @articles.total_pages
    render json: { articles: ActiveModelSerializers::SerializableResource.new(@articles).as_json, count: count }
  end

  def show
    @article = Article.find(params[:id])
    @article_view_counter = ArticleViewCounter.find_or_create_by(article_id: @article.id)
    @article_view_counter.increment!(:count, 1)
    render json: @article
  end
end
