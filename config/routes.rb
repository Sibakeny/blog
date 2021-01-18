# frozen_string_literal: true

Rails.application.routes.draw do

  # 管理画面
  draw :admin

  # 表画面
  root to: 'guest/home#index'

  namespace :guest do
    draw :article

    get 'about', to: 'about#index'
    get 'contact', to: 'contact#index'
  end

end
