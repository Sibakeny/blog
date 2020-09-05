class QiitaSyncsController < ApplicationController
  def index
    QiitaItemSyncService.sync!
  end
end
