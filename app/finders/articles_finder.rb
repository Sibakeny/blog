class ArticlesFinder
  attr_accessor :params

  def initialize(params = {})
    @params = params
  end

  # 検索ロジックが増えたら、ここに追加していく
  def call
    articles = Article.all
    articles = by_query(articles)

    articles
  end

  private

  def by_query(articles)
    return articles if @params[:query].blank?

    articles.by_query(@params[:query])
  end
end
