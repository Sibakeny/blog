class Articles::ConfirmsController < ApplicationController

  def new_modal
    @article_form = params[:article_form]
  end

end
