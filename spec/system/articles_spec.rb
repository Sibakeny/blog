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
    create(:article, title: 'first_article')
    create(:article, title: 'second_article')
    create(:category, name: 'ruby', category_type: 'language')
    create(:category, name: 'ruby on rails', category_type: 'framework')
  end

  describe '記事一覧画面' do
    before do
      login(@user)
    end
    it '記事一覧が表示されること' do
      visit admin_articles_path
      expect(page).to have_content 'first_article'
      expect(page).to have_content 'second_article'
    end

    it '記事が作成日時の降順で表示されていること' do
      visit admin_articles_path
      expect(find('.table').all('tr')[1]).to have_content 'second_article'
      expect(find('.table').all('tr')[2]).to have_content 'first_article'
    end

    it '記事の削除が行えること' do
      visit admin_articles_path
      find('.table').all('tr')[1].click_link('削除')
      expect(page).to_not have_content 'second_article'
      expect(page).to have_content 'first_article'
    end
  end

  describe '記事詳細画面' do
    before do
      login(@user)
    end

    it '記事の詳細画面が表示されること' do
      visit admin_articles_path
      find('.table').all('tr')[1].click_link('表示')
      expect(page).to have_content 'second_article'
      expect(page).to have_content 'body'

      visit admin_articles_path
      find('.table').all('tr')[2].click_link('表示')
      expect(page).to have_content 'first_article'
      expect(page).to have_content 'body'
    end
  end

  describe '記事編集画面' do
    before do
      login(@user)
      @article = Article.last
    end

    it '記事の編集ができること' do
      visit admin_articles_path
      find('.table').all('tr')[1].click_link('編集')
      expect(page).to have_content 'second_article'
      expect(page).to have_content 'body'

      fill_in 'タイトル', with: 'update title'
      fill_in '本文', with: 'update body'
      click_button '更新'

      expect(page).to have_content 'update title'
      expect(page).to have_content 'update body'
    end

    it '画像のアップロードができること' do
      expect(@article.images.attached?).to be_falsy

      visit edit_admin_article_path(@article)
      attach_file 'image-file-field', "#{Rails.root}/spec/files/test-image.jpg", make_visible: true
      click_button 'アップロード'

      expect(page).to have_content '登録画像'

      wait_condition { @article.images.attached? }

      expect(@article.images.attached?).to be_truthy
      expect(page).to have_css('.image-card-wrapper')
    end

    context 'タイトルが空の場合' do
      it '記事の作成が失敗すること' do
        visit edit_admin_article_path(@article)

        expect do
          fill_in 'タイトル', with: ''
          fill_in '本文', with: 'new body'
          check 'ruby'
          click_button '更新'
        end.to change { Article.count }.by(0)

        expect(page).to have_content 'タイトルを入力してください'
      end
    end

    context '本文がからの場合' do
      it '記事の作成が失敗すること' do
        visit edit_admin_article_path(@article)

        expect do
          fill_in 'タイトル', with: 'new title'
          fill_in '本文', with: ''
          check 'ruby'
          click_button '更新'
        end.to change { Article.count }.by(0)

        expect(page).to have_content '本文を入力してください'
      end
    end
  end

  describe '記事作成画面' do
    before do
      login(@user)
    end

    it '記事の作成ができること' do
      visit admin_articles_path
      click_link '作成'

      fill_in 'タイトル', with: 'new title'
      fill_in '本文', with: 'new body'
      check 'ruby'
      click_button '作成'

      expect(page).to have_content 'new title'
      expect(page).to have_content 'new body'
      expect(Article.all.last.categories.first.name).to eq 'ruby'
    end

    context 'タイトルが空の場合' do
      it '記事の作成が失敗すること' do
        visit admin_articles_path
        click_link '作成'

        expect do
          fill_in '本文', with: 'new body'
          check 'ruby'
          click_button '作成'
        end.to change { Article.count }.by(0)

        expect(page).to have_content 'タイトルを入力してください'
      end
    end

    context '本文がからの場合' do
      it '記事の作成が失敗すること' do
        visit admin_articles_path
        click_link '作成'

        expect do
          fill_in 'タイトル', with: 'new title'
          check 'ruby'
          click_button '作成'
        end.to change { Article.count }.by(0)

        expect(page).to have_content '本文を入力してください'
      end
    end
  end
end
