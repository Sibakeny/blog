# frozen_string_literal: true

module Shared::ValidationHelper
  def form_validation_message(form_model, column)
    return unless form_model.errors.include?(column.to_sym)

    p form_model
    p form_model.errors

    content_tag(:div, class: 'd-flex justify-content-start') do
      concat content_tag(:p, form_model.errors.full_messages_for(column.to_sym).first, class: 'text-danger text-sm')
    end
  end
end
