# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /articles' do
    before do
      @article1 = create(:article, title: 'title1', body: 'sample', created_at: Date.new(2020, 4, 1))
      @article2 = create(:article, title: 'title2', body: 'test', created_at: Date.new(2020, 4, 10))
    end

    it '記事一覧の取得ができること' do
      get '/api/articles', params: {category: '', keyword: ''}
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      p json
      expect(json['articles'].length).to eq 2
      expect(json['articles'].first['title']).to eq 'title2'
      expect(json['articles'].last['title']).to eq 'title1'
    end

    describe '検索' do
        it 'カテゴリでの検索ができること' do
            category = create(:category, name: 'ruby')
            @article1.categories << category

            get '/api/articles', params: { category: 'ruby' }
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 1
            expect(json['articles'].first['title']).to eq @article1.title

            get '/api/articles', params: { category: 'rails' }
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 0
        end

        it 'キーワードで検索できること' do
            get '/api/articles', params: { keyword: 'test' }
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 1
            expect(json['articles'].first['body']).to eq 'test'
            
            get '/api/articles', params: { keyword: 'title' }
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 2
            expect(json['articles'].first['title']).to eq 'title2'
            expect(json['articles'].last['title']).to eq 'title1'
        end
    end

    describe 'ソート' do
        it '新着順でソートができること' do
            get '/api/articles', params: { order_type: 'created_at'}
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 2
            expect(json['articles'].first['title']).to eq 'title2'
            expect(json['articles'].last['title']).to eq 'title1'
        end

        it 'pv数でソードができること' do
            1.times do 
                ArticleViewCounter.create(article_id: @article2.id)
            end
            
            2.times do 
                ArticleViewCounter.create(article_id: @article1.id)
            end            

            get '/api/articles', params: { order_type: 'view_count' }
            json = JSON.parse(response.body)
            expect(json['articles'].length).to eq 2
            expect(json['articles'].first['title']).to eq 'title1'
            expect(json['articles'].last['title']).to eq 'title2'
        end
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
