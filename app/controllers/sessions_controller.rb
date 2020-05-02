# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :set_current_user

  def show; end

  def create
    user = User.find_by(email: params[:email])

    return if !user.authenticate(params[:password])

    session[:user_id] = user.id
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token

    redirect_to root_path
  end

  def destroy
    current_user.update_attribute(:remember_digest, nil)
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    redirect_to session_path
  end
end
