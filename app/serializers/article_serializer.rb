class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  has_many :categories, serializer: CategorySerializer do
    object.categories
  end
end
