require 'rails_helper'

RSpec.describe 'Articles', type: :request do
    describe 'GET /articles' do
        before do
            create(:article, title: 'title1')
            create(:article, title: 'title2')
        end

        it '記事一覧の取得ができること' do
            get "/api/articles"
            expect(response.status).to eq 200
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 2
            expect(json['articles'].first['title']).to eq 'title2'
            expect(json['articles'].last['title']).to eq 'title1'
        end
    end

    describe 'GET /articles/:id' do
        before do
            @article = create(:article, title: 'title1')
        end

        it '記事の情報が取得できること' do
            get "/api/articles/#{@article.id}"
            expect(response.status).to eq 200
            json = JSON.parse(response.body)
            expect(json['title']).to eq 'title1'
        end
    end
end