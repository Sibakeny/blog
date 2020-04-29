# frozen_string_literal: true

class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :short_body, :created_at, :view_count

  has_many :categories, serializer: CategorySerializer do
    object.categories
  end

  def short_body
    ActionController::Base.helpers.strip_tags(object.body)[0..100] + '.......'
  end

  def created_at
    object.created_at.strftime('%Y年%-m月%-d日')
  end

  def view_count
    object.article_view_counters.length || 0
  end
end
