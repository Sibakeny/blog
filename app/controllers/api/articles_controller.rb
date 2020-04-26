class Api::ArticlesController < ApplicationController
    def index
        @articles = Article.all.page(params[:page]).per(8)
        render json: @articles
    end

    def show
        @article = Article.find(params[:id])
        @article_view_counter = ArticleViewCounter.find_or_create_by(article_id: @article.id)
        @article_view_counter.increment!(:count, 1)
        render json: @article
    end
end
