class Guest::Articles::CategorizedArticlesController < Guest::Base

  def index
    @category = Category.find(params[:category_id])
    @articles = @category.articles
  end
end