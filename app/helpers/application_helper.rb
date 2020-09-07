# frozen_string_literal: true

module ApplicationHelper
  include Shared::ValidationHelper
  include Shared::MarkdownHelper

  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
      concat raw(message)
    end
  end

  def sidebar_active(navbar_menu)
    path = Rails.application.routes.recognize_path(request.url)
    'active' if path[:controller] =~ /^#{navbar_menu}/
  end
end
