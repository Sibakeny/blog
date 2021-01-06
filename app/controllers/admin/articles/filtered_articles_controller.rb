class Admin::Articles::FilteredArticlesController < Admin::Base
  def index
    @query = params[:query]
    @articles = ArticlesFinder.new(params).call
    @articles = @articles.page.per(Article::TILE_PAGE_SIZE)
  end
end
