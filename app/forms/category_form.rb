class CategoryForm
  include ActiveModel::Model

  attr_accessor :name, :category_type


  def save
    category = Category.new(name: name, category_type: category_type)
    category.save
  end
end