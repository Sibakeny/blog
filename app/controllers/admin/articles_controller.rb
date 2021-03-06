# frozen_string_literal: true

class Admin::ArticlesController < Admin::Base
  before_action :set_article, only: %i[show edit update destroy]

  add_breadcrumb 'HOME', :root_path
  add_breadcrumb '記事一覧', :admin_articles_path

  def index
    @articles = Article.where(is_draft: false)
                       .includes(:qiita_stats)
                       .order(created_at: :desc)
                       .page(params[:page]).per(Article::LIST_PAGE_SIZE)
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
      @article_form = ArticleForm.new(
        article: Article.friendly.find(params[:article_form][:article][:id]),
        params: params[:article_form],
        post_qiita: params[:post_qiita].to_b,
        post_twitter: params[:post_twitter].to_b
      )

      if @article_form.save
        redirect_to admin_articles_path, notice: '記事を作成しました。'
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
        redirect_to admin_articles_path, notice: '記事を更新しました。'
      else
        render :edit
      end
    end
  end

  def destroy
    @article.destroy!

    redirect_to admin_articles_path
  end

  private def set_article
    @article = Article.friendly.find(params[:id])
  end
end
