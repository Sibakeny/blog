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
    'active' if path[:controller] =~ %r{^admin/#{navbar_menu}}
  end

  def total_pv
    ArticleViewCounter.all.count +
      (QiitaStat.all.group(' date_format(created_at, "%Y-%m-%d")').select('sum(page_view_count) sum, date_format(created_at, "%Y-%m-%d") created_at_date').to_a.last&.sum || 0)
  end

  def total_like
    QiitaStat.all.group(' date_format(created_at, "%Y-%m-%d")').select('sum(like_count) sum, date_format(created_at, "%Y-%m-%d") time').to_a.last&.sum || 0
  end
end
