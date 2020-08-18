# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:show, :new, :create, :destroy]

  def show; end

  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    @user = User.find_by(email: @form.email)
    if @user&.authenticate(@form.password)
      login
      flash.notice = 'ログインしました。'
      redirect_to root_path
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render :new
    end
  end

  def destroy
    logout
    flash.notice = 'ログアウトしました。'
    redirect_to login_path
  end

  private

  def login_params
    params.require(:login_form).permit(:email, :password)
  end
end
