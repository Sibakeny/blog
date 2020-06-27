# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  add_breadcrumb 'HOME', :root_path
  add_breadcrumb '記事一覧', :articles_path

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(16)
  end

  def show
    add_breadcrumb '記事詳細'
  end

  def new
    add_breadcrumb '記事作成'
    @article = Article.new
    @article.categories.build
  end

  def create
    Article.transaction do
      @article = Article.new(article_params)

      if @article.save
        categories_params[:ids].each do |id|
          next if id.blank?

          @article.categories << Category.find(id)
        end
        redirect_to articles_path, notice: '記事を作成しました。'
      else
        render :new
      end
    end
  end

  def edit
    add_breadcrumb '記事更新'
  end

  def update
    @article.update!(article_params)
    redirect_to article_path, notice: '記事を更新しました。'
  end

  def destroy
    @article.destroy!

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, images: [])
  end

  def categories_params
    params.require(:category).permit(ids: [])
  end
end
