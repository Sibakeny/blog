require 'rails_helper'

RSpec.describe User, type: :model do

  # ==================ユーザー作成===============================

  describe 'ユーザーの作成' do
    context 'パラメータが正常な場合' do
      it 'ユーザーを作成できること' do
        user = User.new(email: 'text@example.com', password: 'password')
        expect(user).to be_valid
      end

      it 'ユーザー作成時にpassword_digestが作成されること' do
        user = User.new(email: 'test@example.com', password: 'password')
        expect(user.password_digest).to_not be_empty
        expect(user.authenticate('password')).to be_truthy
        expect(user.authenticate('testtest')).to_not be_truthy
      end
    end

    context 'パラメータが異常な場合' do
      context 'emailの形式が正しくない場合' do
        it 'ユーザー作成できないこと' do
          user = User.new(email: 'test.test', password: 'password')
          expect(user).to_not be_valid
        end
      end

      context 'emailが存在しない場合' do
        it 'ユーザー作成できないこと' do
          user = User.new(password: 'password')
          expect(user).to_not be_valid
        end
      end

      context 'passwordが存在しない場合' do
        it 'ユーザー作成できないこと' do
          user = User.new(email: 'test@example.com')
          expect(user).to_not be_valid
        end
      end
    end
  end

  # ==================PublicMethod===============================

  describe 'ログイン関係' do
    describe 'remember' do
      it 'remember_digestが保存されること' do
        user = create(:user)
        expect(user.remember_digest).to eq nil
        user.remember
        expect(user.remember_digest).to_not be_empty
      end
    end

    describe 'authenticated?' do
      it 'remember_digestがある場合にtrueが返ること' do
        user = create(:user)
        user.remember
        cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
        expect(user.authenticated?(cookies['remember_token'])).to be_truthy
      end

      it 'remember_digestとremember_tokenが異なる場合にfalseが返ること' do
        user = create(:user)
        user.remember
        cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
        cookies.permanent.signed[:user_id] = user.id
        dummy_token = User.new_token
        cookies.permanent[:remember_token] = dummy_token
        expect(user.authenticated?(cookies['remember_token'])).to be_falsy
      end
    end
  end
end
