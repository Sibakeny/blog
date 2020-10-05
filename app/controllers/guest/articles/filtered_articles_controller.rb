class Guest::Articles::FilteredArticlesController < Guest::Base
  def index
    @query = params[:query]
    @articles = Article.where('title LIKE ?', "%#{@query}%").page.per(8)
  end
end
