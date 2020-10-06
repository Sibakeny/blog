class Guest::Articles::FilteredArticlesController < Guest::Base
  def index
    @query = params[:query]
    @articles = Article.where('title LIKE ?', "%#{@query}%").pag.per(Article::TILE_PAGE_SIZE)
  end
end
