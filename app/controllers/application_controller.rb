# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    redirect_to session_path unless current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user || User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def login
    session[:user_id] = @user.id
    @user.remember
    cookies.permanent.signed[:user_id] = @user.id
    cookies.permanent[:remember_token] = @user.remember_token
  end

  def logout
    current_user.update_attribute(:remember_digest, nil)
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
