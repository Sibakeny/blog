class Guest::HomeController < Guest::Base
  def index
    @articles = Article.published_articles.page(params[:page]).per(Article::TILE_PAGE_SIZE)
  end
end
