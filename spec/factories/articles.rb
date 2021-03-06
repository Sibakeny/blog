# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'title' }
    body { 'body' }
    is_draft { false }
  end
end
