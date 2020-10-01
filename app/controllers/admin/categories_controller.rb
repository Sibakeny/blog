# frozen_string_literal: true

class Admin::CategoriesController < Admin::Base
  before_action :set_category, only: %i[show edit update destroy]

  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'カテゴリ一覧', :admin_categories_path

  def index
    @categories = Category.all.order(category_type: :asc).order(created_at: :desc)
  end

  def show; end

  def new
    add_breadcrumb 'カテゴリ作成'
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'カテゴリを作成しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    @category.assign_attributes(category_params)
    if @category.save
      redirect_to :admin_categories
    else
      render :edit
    end
  end

  def destroy
    @category.destroy!
    redirect_to admin_categories_path, notice: 'カテゴリを削除しました'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end
