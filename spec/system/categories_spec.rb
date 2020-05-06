require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  before do
    @user = create(:user)
    create(:article, title: 'first_article')
    create(:article, title: 'second_article')
    create(:category, name: 'ruby', category_type: 'language')
    create(:category, name: 'react', category_type: 'framework')
  end

  describe 'カテゴリ一覧画面' do
    before do
        login(@user)
    end

    it 'カテゴリ一一覧が表示されること' do
        visit categories_path
        expect(find('.table').all('tr')[1]).to have_content 'react'
        expect(find('.table').all('tr')[1]).to have_content 'framework'
        expect(find('.table').all('tr')[2]).to have_content 'ruby'
        expect(find('.table').all('tr')[2]).to have_content 'language'
    end
  end

  describe 'カテゴリ作成画面' do
    before do
        login(@user)
    end

    it 'カテゴリの作成ができること' do
        visit categories_path
        click_link '追加'

        expect(page).to have_select('category_category_type', options: ['language', 'framework'])

        fill_in 'Name', with: 'JavaScript'
        select 'language', from: 'category_category_type'

        click_button '作成'

        expect(find('.table').all('tr')[1]).to have_content 'JavaScript'
        expect(find('.table').all('tr')[1]).to have_content 'language'
    end
  end
end