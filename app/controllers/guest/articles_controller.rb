class Guest::ArticlesController < Guest::Base

  def show
    @article = Article.find(params[:id])
  end
end
