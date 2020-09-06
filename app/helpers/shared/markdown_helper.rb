# frozen_string_literal: true

module Shared::MarkdownHelper
  # markdown用の画像のURL
  def markdown_image_url(image_attachment)
    "![#{image_attachment.blob.filename}](#{polymorphic_url(image_attachment)})"
  end
end
