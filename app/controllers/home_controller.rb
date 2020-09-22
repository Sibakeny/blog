class HomeController < ApplicationController
  def index
    @articles = Article.all.limit(8)
  end
end
