# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  def login(user)
    session[:user_id] = user.id
    @user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logout
    current_user.update_attribute(:remember_digest, nil)
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
