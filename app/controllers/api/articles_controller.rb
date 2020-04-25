class Api::ArticlesController < ApplicationController
    def index
        @articles = Article.all.page(params[:page]).per(8)
        render json: @articles
    end

    def show
        @article = Article.find(params[:id])
        render json: @article
    end
end
