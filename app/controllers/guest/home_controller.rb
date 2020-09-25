class Guest::HomeController < Guest::Base
  def index
    @articles = Article.all.limit(8)
  end
end
