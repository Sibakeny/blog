# frozen_string_literal: true

Rails.application.routes.draw do

  # 管理画面
  draw :admin

  # 表画面
  root to: 'guest/home#index'

  namespace :guest do
    draw :article
  end

end
