# frozen_string_literal: true

class Admin::SessionsController < Admin::Base
  include Admin::Authentication
  skip_before_action :authorize, only: %i[show new create destroy]

  def show; end

  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    @user = User.find_by(email: @form.email)
    if @user&.authenticate(@form.password)
      login(@user)
      flash.notice = 'ログインしました。'
      redirect_to admin_root_path
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render :new
    end
  end

  def destroy
    logout
    flash.notice = 'ログアウトしました。'
    redirect_to admin_login_path
  end

  private def login_params
    params.require(:login_form).permit(:email, :password)
  end
end
