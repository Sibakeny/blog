class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
        @article.categories.build
    end

    def create
        @article = Article.create!(article_params)

        categories_params[:ids].each do |id|
            next if id.blank?
            @article.categories << Category.find(id)
        end

        redirect_to articles_path
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.update!(article_params)
        redirect_to articles_path
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy!

        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :body)
    end

    def categories_params
        params.require(:category).permit(ids: [])
    end
end
