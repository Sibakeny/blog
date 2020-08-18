# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  before_action :authorize

  def authorize
    if current_user.blank?
      redirect_to :login
    end
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
    @current_user
  end
end

https://sbkn-blog-283488325.ap-northeast-1.elb.amazonaws.com/login