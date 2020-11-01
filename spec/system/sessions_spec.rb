# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    @user = create(:user, password: 'password')
  end

  describe 'ログイン画面' do
    context 'パスワードが異なる場合' do
      it 'ログインできないこと' do
        visit admin_login_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'dummy'
        click_button 'commit'
        expect(page).to_not have_content '記事一覧'
        expect(page).to_not have_content 'カテゴリ一覧'
        expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません。'
      end
    end

    context 'メールアドレスが異なる場合' do
      it 'ログインできないこと' do
        visit admin_login_path
        fill_in 'Email', with: 'dummy'
        fill_in 'Password', with: 'password'
        click_button 'commit'

        expect(page).to_not have_content '記事一覧'
        expect(page).to_not have_content 'カテゴリ一覧'
        expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません。'
      end
    end

    context 'パスワードが正しい場合' do
      it 'ログインできること' do
        visit admin_login_path
        expect(page).to have_content 'Email'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'password'
        click_button 'commit'
        expect(page).to have_content '記事一覧'
        expect(page).to have_content 'カテゴリ一覧'
        expect(page).to have_content 'ログインしました。'
      end
    end
  end
end
