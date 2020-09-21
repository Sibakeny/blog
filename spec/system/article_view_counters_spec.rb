# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  def wait_condition(interval: 0.5, limit: 10, &condition)
    start_at = Time.now
    raise 'must give block!' unless block_given?

    until condition.call
      sleep interval
      break puts('time out') if (Time.now - start_at) > limit
    end
  end

  before do
    @user = create(:user)
    @article_1 = create(:article, title: 'first_article')
    @article_2 = create(:article, title: 'second_article')

    10.times do
      @article_1.article_view_counters.create!
    end

    5.times do
      @article_2.article_view_counters.create!
    end
  end

  describe 'アクセスログメイン画面' do
    before do
      login(@user)
    end
    it '記事一覧が表示されること' do
      visit admin_article_view_counters_path
      expect(page).to have_content '全体のPV数'
      expect(page.all('.popular-articles-container .card')[0]).to have_content @article_1.title
      expect(page.all('.popular-articles-container .card')[1]).to have_content @article_2.title
    end
  end

  describe 'アクセスログ記事詳細画面' do
    before do
      login(@user)
    end

    it '記事の詳細画面が表示されること' do
      visit admin_article_view_counters_path

      page.all('.popular-articles-container .card a')[0].click
      expect(page).to have_content '記事のPV数'
      expect(page).to have_content @article_1.title
      expect(page).to have_content @article_1.body
    end
  end
end
