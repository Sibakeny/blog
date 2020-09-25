class Guest::HomeController < Guest::Base
  def index
    @articles = Article.published_articles.page(params[:page]).per(8)
  end
end
