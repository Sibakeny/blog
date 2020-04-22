class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :short_body

  has_many :categories, serializer: CategorySerializer do
    object.categories
  end

  def short_body
    ActionController::Base.helpers.strip_tags(object.body)[0..100] + "......."
  end
end
