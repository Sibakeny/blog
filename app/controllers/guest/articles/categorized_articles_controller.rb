class Guest::Articles::CategorizedArticlesController < Guest::Base
  def index
    @category = Category.find(params[:category_id])
    @articles = @category.articles.page(params[:page]).per(Article::TILE_PAGE_SIZE)
  end
end
