class Admin::Articles::FilteredArticlesController < Admin::Base
  def index
    @query = params[:query]
    @articles = Article.where('title LIKE ?', "%#{@query}%").page.per(Article::TILE_PAGE_SIZE)
  end
end
