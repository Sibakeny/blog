# frozen_string_literal: true

module ApplicationHelper
  include Shared::ValidationHelper

  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
      concat raw(message)
    end
  end

  def sidebar_active(navbar_menu)
    p controller.controller_name
    'active' if controller.controller_name == navbar_menu
  end
end
