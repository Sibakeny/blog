class QiitaSyncsController < ApplicationController
  def index
    client = Qiita::Sdk::Client.new
    res = client.fetch_user_items(user_id: 'sibakenY')

    hash = JSON.parse(res.body)
    hash.each do |item|
      Article.create(title: item["title"], body: item["body"] )
    end
  end
end
