# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  before_action :authorize

  def authorize
    redirect_to :login if current_user.blank?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
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
