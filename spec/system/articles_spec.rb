require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  before do
    @user = create(:user)
    create(:article, title: 'first_article')
    create(:article, title: 'second_article')
  end

  describe '記事一覧画面' do
    before do
      login(@user)
    end
    it '記事一覧が表示されること' do
      visit articles_path
      expect(page).to have_content 'first_article'
      expect(page).to have_content 'second_article'
    end
  
    it '記事が作成日時の降順で表示されていること' do
      visit articles_path
      expect(find('.table').all('tr')[1]).to have_content 'second_article'
      expect(find('.table').all('tr')[2]).to have_content 'first_article'
    end

    it '記事の削除が行えること' do
      visit articles_path
      find('.table').all('tr')[1].click_link("削除")
      expect(page).to_not have_content 'second_article'
      expect(page).to have_content 'first_article'
    end
  end

  describe '記事詳細画面' do
    before do
      login(@user)
    end

    it '記事の詳細画面が表示されること' do
      visit articles_path
      find('.table').all('tr')[1].click_link("表示")
      expect(page).to have_content 'second_article'
      expect(page).to have_content 'body'

      visit articles_path
      find('.table').all('tr')[2].click_link("表示")
      expect(page).to have_content 'first_article'
      expect(page).to have_content 'body'
    end
  end

  describe '記事編集画面' do
    before do
      login(@user)
    end

    it '記事の編集ができること' do
      visit articles_path
      find('.table').all('tr')[1].click_link('編集')
      expect(page).to have_content 'second_article'
      expect(page).to have_content 'body'

      fill_in 'Title', with: 'update title'
      fill_in 'Body', with: 'update body'
      click_button '更新'

      expect(page).to have_content 'update title'
      expect(page).to have_content 'update body'
    end
  end

  describe '記事作成画面' do
    before do
      login(@user)
    end

    it '記事の作成ができること' do
      visit articles_path
      click_link '作成'

      fill_in 'Title', with: 'new title'
      fill_in 'Body', with: 'new body'
      click_button '作成'

      expect(page).to have_content 'new title'
      expect(page).to have_content 'new body'
    end
  end
end