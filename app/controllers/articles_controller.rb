# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    add_breadcrumb 'HOME', root_path
    add_breadcrumb '記事一覧'
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(16)
  end

  def show
    add_breadcrumb 'HOME', root_path
    add_breadcrumb '記事一覧', articles_path
    add_breadcrumb '記事詳細'
    @article = Article.find(params[:id])
  end

  def new
    add_breadcrumb 'HOME', root_path
    add_breadcrumb '記事一覧', articles_path
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
    add_breadcrumb 'HOME', root_path
    add_breadcrumb '記事一覧', articles_path
    add_breadcrumb '記事更新'
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update!(article_params)
    redirect_to article_path, notice: '記事を更新しました。'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, images: [])
  end

  def categories_params
    params.require(:category).permit(ids: [])
  end
end
