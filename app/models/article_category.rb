# frozen_string_literal: true

class ArticleCategory < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :article, optional: true
end
