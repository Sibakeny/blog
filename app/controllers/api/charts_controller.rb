class Api::ChartsController < ApplicationController
    def index
        article_values = Article.select("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d') as time, count(*) as sum")
                                .joins(:article_view_counters).group("DATE_FORMAT(article_view_counters.created_at, '%Y-%m-%d')")
                                .order('time asc').limit(30)

        render json: article_values, each_serializer: ChartsSerializer
    end
end
