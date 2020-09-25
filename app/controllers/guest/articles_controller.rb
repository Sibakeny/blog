class Guest::ArticlesController < Guest::Base

  def show
    @article = Article.find(params[:id])
    @article.count_pv
  end
end
