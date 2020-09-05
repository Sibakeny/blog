class QiitaSyncsController < ApplicationController
  def index
  end

  def sycn_items
    QiitaItemSyncService.new.sync!
  end
end
