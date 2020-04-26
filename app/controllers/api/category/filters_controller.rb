class Api::Category::FiltersController < ApplicationController
    def index
        category = Category.find_by(name: params[:name])
        articles = category.articles.page(params[:page]).per(8)

        render json: articles
    end
end
