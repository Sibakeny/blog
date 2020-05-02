# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'SAMPLE CATEGORY' }
    category_type { 'language' }
  end
end
