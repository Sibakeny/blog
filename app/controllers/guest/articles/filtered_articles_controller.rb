class Guest::Articles::FilteredArticlesController < Guest::Base
  def index
    @query = params[:query]
    @articles = ArticlesFinder.new(params).call
    @articles = @articles.page.per(Article::TILE_PAGE_SIZE)
  end
end
