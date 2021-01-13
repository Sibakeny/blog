class Admin::Articles::LeaveFormsController < ApplicationController
  def create
    # TODO: tilte,bodyを書きかけの場合は削除しない&&データの登録を行う
    @article = Article.friendly.find_by(id: params[:article_id])
    @article.destroy! if @article.present? && @article.body.blank? && @article.title.blank?
  end
end
