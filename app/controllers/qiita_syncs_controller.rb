class QiitaSyncsController < ApplicationController
  def index
  end

  def sycn_items
    QiitaItemSyncService.sync!
  end
end
