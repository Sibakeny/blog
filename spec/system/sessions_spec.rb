require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  before do
    @user = create(:user, password: 'password')
  end

  describe 'ログイン画面' do
    context 'パスワードが異なる場合' do
        it 'ログインできないこと' do
            visit session_path
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: 'dummy'
            click_button 'commit'
            expect(page).to_not have_content '記事一覧'
            expect(page).to_not have_content 'カテゴリ一覧'
        end
    end

    context 'パスワードが正しい場合' do
        it 'ログインできること' do
            visit session_path
            expect(page).to have_content 'Email'
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: 'password'
            click_button 'commit'
            expect(page).to have_content '記事一覧'
            expect(page).to have_content 'カテゴリ一覧'
        end
    end
  end
end