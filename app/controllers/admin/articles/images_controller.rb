# frozen_string_literal: true

class Admin::Articles::ImagesController < Admin::Base
  before_action :set_article

  def create
    @article.images.attach(params[:images])
  end

  def destroy
    image = @article.images.find(params[:id])
    image.purge
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def article_image_params
    params.permit(images: [])
  end
end
