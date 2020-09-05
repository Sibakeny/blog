class QiitaItemSyncService

  def self.read_items
    client = Qiita::Sdk::Client.new
    res = client.fetch_user_items(user_id: 'sibakenY')
    @item_params = JSON.parse(res.body)
  end

  def self.sync_items
    @item_params.each do |params|
      article = Article.find_by(qiita_item_id: params['id'])
      if article
        article.update!(title: params['title'], body: params['body'])
      else
        article = Article.create!(title: params['title'], body: params['body'])
      end
      # TODO: 一日に一つしか作成されない様にする
      article.qiita_stats.create!(page_view_count: params['page_views_count'], like_count: params['likes_count'])
    end
  end

  def self.sync!
    read_items
    sync_items
  end
end
