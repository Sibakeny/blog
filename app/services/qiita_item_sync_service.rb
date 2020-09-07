class QiitaItemSyncService
  attr_accessor :total_sync_count, :new_sync_article_count

  def initialize
    @new_sync_article_count = 0
  end

  def read_items
    @client = Qiita::Sdk::Client.new do |config|
      config.access_token = ENV['QIITA_ACCESS_TOKEN']
    end
    res = @client.fetch_user_items(user_id: 'sibakenY')
    @item_params = JSON.parse(res.body)
    @total_sync_count = @item_params.length
  end

  def sync_items
    @item_params.each do |params|
      # qiita apiの使用で記事一覧を取得する際はpv数を取得できないので記事単体の情報を毎回取得している
      res = @client.fetch_item(item_id: params['id'])
      article_detail_params = JSON.parse(res.body)
      article = Article.find_by(qiita_item_id: params['id'])
      if article
        article.update!(title: article_detail_params['title'], body: article_detail_params['body'])
      else
        @new_sync_article_count += 1
        article = Article.create!(title: article_detail_params['title'], body: article_detail_params['body'], qiita_item_id: params['id'])
      end
      # TODO: 一日に一つしか作成されない様にする
      article.qiita_stats.create!(page_view_count: article_detail_params['page_views_count'], like_count: article_detail_params['likes_count'])
    end
  end

  def sync!
    read_items
    sync_items
  end
end
