# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :set_current_user

  def show; end

  def create
    @user = User.find_by(email: params[:email])
    return unless @user.authenticate(params[:password])

    login
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to session_path
  end
end
