module Shared::ValidationHelper
  def form_validation_message(form_model, column)
    if form_model.errors.include?(column.to_sym)
      content_tag(:div, class: "d-flex justify-content-start") do
        concat content_tag(:p, form_model.errors.full_messages_for(column.to_sym).first, class: 'text-danger text-sm')
      end
    end
  end
end
