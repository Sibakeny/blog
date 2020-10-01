# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :set_layout

  private def set_layout
    if params[:controller].match(/\A(admin)/)
      'admin'
    else
      'application'
    end
  end
end
