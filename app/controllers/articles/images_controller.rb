class Articles::ImagesController < ApplicationController
  before_action :set_article

  def create
    @article.images.attach(params[:images])
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
  
  def article_image_params
    params.permit(images: [])
  end
end
