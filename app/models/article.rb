class Article < ApplicationRecord
    has_many :article_categories
    has_many :categories, through: :article_categories
    accepts_nested_attributes_for :article_categories
end
