# frozen_string_literal: true

class Api::Category::FiltersController < ApplicationController
  def index
    category = Category.find_by(name: params[:name])
    articles = category.articles.page(params[:page]).per(8)
    count = articles.total_pages

    render json: { articles: ActiveModelSerializers::SerializableResource.new(articles).as_json, count: count }
  end
end
