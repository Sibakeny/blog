# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '記事作成' do
    context 'パラメータに問題がない場合' do
      it '記事が作成できること' do
        article = Article.new(title: 'title', body: 'bodybody')
        expect(article).to be_valid
      end
    end

    context 'titleがない場合' do
      xit '記事が作成できないこと' do
        article = Article.new(body: 'body')
        expect(article).to_not be_valid
      end
    end

    context 'bodyがない場合' do
      xit '記事が作成できないこと' do
        article = Article.new(title: 'title')
        expect(article).to_not be_valid
      end
    end
  end

  describe 'カテゴリとの結びつき' do
    before do
      @category = create(:category, name: 'category')
      @article = create(:article)
      @article.categories << @category
    end

    it '記事からカテゴリを参照できること' do
      categories = @article.categories
      expect(categories.first).to eq @category
    end

    it 'カテゴリから記事を参照できること' do
      articles = @category.articles
      expect(articles.first).to eq @article
    end
  end
end
