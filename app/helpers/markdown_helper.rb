# frozen_string_literal: true

module MarkdownHelper
  require 'redcarpet'
  require 'coderay'

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.present? ? language.split(':')[0] : ''

      allow_langs = %w[
        ruby
        yaml
        html
        css
        md
        javascript
        typescript
        go
        python
      ]

      lang = case language.to_s
             when 'rb'
               'ruby'
             when 'yml'
               'yaml'
             when 'css'
               'css'
             when 'html'
               'html'
             when ''
               'md'
             else
               language
             end

      return unless allow_langs.include?(lang)

      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
    options = {
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end
end
