class Article < ApplicationRecord
    has_many :article_categories
    has_many :categories, through: :article_categories
    has_one :article_view_counter
    accepts_nested_attributes_for :article_categories
end
