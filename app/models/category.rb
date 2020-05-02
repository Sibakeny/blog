# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true
  validates :category_type, presence: true

  enum category_type: { language: 0, framework: 1 }
end
