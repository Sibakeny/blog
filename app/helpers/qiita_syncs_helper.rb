module QiitaSyncsHelper
  def qiita_already_synced_today?
    QiitaStat.where('created_at >= ?', Date.today).exists?
  end
end
