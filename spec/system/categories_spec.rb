# frozen_string_literal: true

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
      visit admin_categories_path
      expect(find('.custom-table').all('.custom-table-row')[1]).to have_content 'ruby'
      expect(find('.custom-table').all('.custom-table-row')[1]).to have_content '言語'
      expect(find('.custom-table').all('.custom-table-row')[2]).to have_content 'react'
      expect(find('.custom-table').all('.custom-table-row')[2]).to have_content 'フレームワーク'
    end

    it '削除ボタンでカテゴリの削除ができること' do
      visit admin_categories_path
      find('.custom-table').all('.custom-table-row')[1].click

      expect {
        find('.destroy-button').click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'カテゴリを削除しました'
      }.to change { Category.count }.by(-1)

    end
  end

  describe 'カテゴリ作成画面' do
    before do
      login(@user)
    end

    it 'カテゴリ(言語)の作成ができること' do
      visit admin_categories_path
      click_link 'カテゴリー作成'

      expect(page).to have_select('category_category_type', options: %w[言語 フレームワーク])

      fill_in 'カテゴリー名', with: 'JavaScript'
      select '言語', from: 'category_category_type'

      click_button '作成'

      expect(page).to have_content 'JavaScript'
      expect(page).to have_content '言語'
      expect(page).to have_content 'カテゴリを作成しました'
    end

    it 'カテゴリ(フレームワーク)の作成ができること' do
      visit admin_categories_path
      click_link 'カテゴリー作成'

      fill_in 'カテゴリー名', with: 'RubyOnRails'
      select 'フレームワーク', from: 'category_category_type'

      click_button '作成'

      expect(page).to have_content 'RubyOnRails'
      expect(page).to have_content 'フレームワーク'
      expect(page).to have_content 'カテゴリを作成しました'
    end
  end
end
