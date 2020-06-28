# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy]

  add_breadcrumb 'HOME', :root_path
  add_breadcrumb 'カテゴリ一覧', :categories_path

  def index
    @categories = Category.all.order(category_type: :asc).order(created_at: :desc)
  end

  def new
    add_breadcrumb 'カテゴリ作成'
    @category = Category.new
  end

  def create
    Category.create!(category_params)
    redirect_to categories_path, notice: 'カテゴリを作成しました'
  end

  def destroy
    @category.destroy!
    redirect_to categories_path, notice: 'カテゴリを削除しました'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end
