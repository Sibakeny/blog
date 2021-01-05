class Admin::QiitaSyncsController < Admin::Base
  def index; end

  def sycn_items
    response = QiitaItemSyncService.new.call

    @total_sync_count = response.payload[:total_sync_count]
    @new_sync_article_count = response.payload[:new_sync_article_count]
  end
end
