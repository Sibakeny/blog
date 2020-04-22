class Api::Category::FiltersController < ApplicationController
    def index
        category = Category.find_by(name: params[:name])
        articles = category.articles

        render json: articles
    end
end
