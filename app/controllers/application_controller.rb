# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        if !current_user
            redirect_to session_path
        end
    end
    
    def current_user
        if (user_id = session[:user_id])
            @current_user || User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                session[:user_id] = user.id
                @current_user = user
            end
        end
    end
end
