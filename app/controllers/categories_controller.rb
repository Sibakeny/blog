# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def new
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
