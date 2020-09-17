# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  add_breadcrumb 'HOME', :root_path
  add_breadcrumb '記事一覧', :articles_path

  def index
    @articles = Article.where(is_draft: false).includes(:qiita_stats).order(created_at: :desc).page(params[:page]).per(16)
  end

  def show
    add_breadcrumb '記事詳細'
  end

  def new
    add_breadcrumb '記事作成'
    @article_form = ArticleForm.new
  end

  def create
    Article.transaction do
      @article_form = ArticleForm.new(article: Article.find(params[:article_form][:article][:id]), params: params[:article_form])

      if @article_form.save
        redirect_to articles_path, notice: '記事を作成しました。'
      else
        render :new
      end
    end
  end

  def edit
    @article_form = ArticleForm.new(article: @article)
    add_breadcrumb '記事更新'
  end

  def update
    Article.transaction do
      @article_form = ArticleForm.new(article: @article, params: params[:article_form])

      if @article_form.save
        redirect_to article_path, notice: '記事を更新しました。'
      else
        render :edit
      end
    end
  end

  def destroy
    @article.destroy!

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
