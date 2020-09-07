class QiitaSyncsController < ApplicationController
  def index; end

  def sycn_items
    q = QiitaItemSyncService.new
    q.sync!

    @total_sync_count = q.total_sync_count
    @new_sync_article_count = q.new_sync_article_count
  end
end
