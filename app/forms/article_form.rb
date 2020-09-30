class ArticleForm
  include ActiveModel::Model

  attr_accessor :article, :categories

  def initialize(article: nil, params: {}, post_qiita: false, post_twitter: false)
    @params = params
    @article = article || Article.create(title: '', body: '')
    @post_qiita = post_qiita
    @post_twitter = post_twitter
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

    @article.assign_attributes(article_params.merge(is_draft: false))
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

    update_qiita if @post_qiita
  end

  def update_qiita
    client = Qiita::Sdk::Client.new do |config|
      config.access_token = ENV['QIITA_ACCESS_TOKEN']
    end

    # TODO: エラー処理
    if @article.qiita_item_id.present?
      client.update_item(item_id: @article.qiita_item_id, title: @article.title, body: @article.body)
    else
      res = client.post_item(title: @article.title, body: @article.body, tags: @article.categories.map(&:name), twitter: @post_twitter)
    end
  end

  private

  def article_params
    @params.require(:article).permit(:title, :body)
  end

  def categories_params
    @params.require(:categories).permit(ids: [])
  end
end
