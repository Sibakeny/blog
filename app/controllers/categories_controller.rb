# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    add_breadcrumb 'HOME', root_path
    add_breadcrumb 'カテゴリ一覧'

    @categories = Category.all.order(category_type: :asc).order(created_at: :desc)
  end

  def new
    add_breadcrumb 'HOME', root_path
    add_breadcrumb 'カテゴリ一覧', categories_path
    add_breadcrumb 'カテゴリ作成'

    @category = Category.new
  end

  def create
    Category.create!(category_params)
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end
