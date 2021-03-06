class QiitaItemSyncService
  def initialize
    @new_sync_article_count = 0
  end

  def call
    read_items
    sync_items

    ServiceResponse.success(payload: { total_sync_count: @total_sync_count, new_sync_article_count: @new_sync_article_count })
  end

  private def read_items
    @client = Qiita::Sdk::Client.new do |config|
      config.access_token = ENV['QIITA_ACCESS_TOKEN']
    end
    res = @client.fetch_user_items(user_id: 'sibakenY')
    @item_params = JSON.parse(res.body)
    @total_sync_count = @item_params.length
  end

  private def sync_items
    @item_params.each do |params|
      # qiita apiの使用で記事一覧を取得する際はpv数を取得できないので記事単体の情報を毎回取得している
      res = @client.fetch_item(item_id: params['id'])
      article_detail_params = JSON.parse(res.body)
      article = Article.find_by(qiita_item_id: params['id'])
      if article
        article.update!(title: article_detail_params['title'], body: article_detail_params['body'])
      else
        @new_sync_article_count += 1
        article = Article.create!(title: article_detail_params['title'], body: article_detail_params['body'], qiita_item_id: params['id'], is_draft: false)
      end

      # Qiitaのタグでcategoryと同じものがあればarticleと紐付ける
      article_detail_params['tags'].each do |tag_params|
        tag_name = tag_params['name']
        categories = Category.where('LOWER(name) LIKE ?', '%' + tag_name.downcase + '%')
        categories.each do |category|
          article.categories << category if category.present? && article.categories.find_by(id: category.id).blank?
        end
      end

      # TODO: 一日に一つしか作成されない様にする
      article.qiita_stats.create!(page_view_count: article_detail_params['page_views_count'], like_count: article_detail_params['likes_count'])
    end
  end
end
