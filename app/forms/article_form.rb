class ArticleForm
  include ActiveModel::Model

  attr_accessor :article, :categories

  def initialize(article: nil, params: {})
    @params = params
    @article = article || Article.create(title: '', body: '')
  end

  def assign_categories_attributes
    new_category_ids = categories_params[:ids].map(&:to_i) - @article.categories.pluck(:id)

    new_category_ids.each do |id|
      next if id.blank? || id == 0

      @article.article_categories.build(category_id: id)
    end
  end

  def save
    # return false if valid?

    @article.assign_attributes(article_params)
    assign_categories_attributes

    # mark_for_destruction的なことができなかったのでここで一つ一つ削除
    destroy_category_ids = @article.categories.pluck(:id) - categories_params[:ids].map(&:to_i)
    destroy_category_ids.each do |id|
      next if id.blank? || id == 0

      # ここで失敗すると予期しない動きになる。
      # validationかけるべきかな？
      @article.categories.destroy(id)
    end

    @article.save
  end

  private

  def article_params
    @params.require(:article).permit(:title, :body)
  end

  def categories_params
    @params.require(:categories).permit(ids: [])
  end
end
