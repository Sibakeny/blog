class Admin::Articles::ConfirmsController < Admin::Base
  def new_modal
    @article_form = params[:article_form]
  end
end
