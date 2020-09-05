import marked from 'marked';
import hljs from 'highlight.js';

console.log("readed")

function showMarkdown() {
  var md_content = $('.article-body-form').val()
  marked.setOptions({
    // code要素にdefaultで付くlangage-を削除
    langPrefix: '',
    // highlightjsを使用したハイライト処理を追加
    highlight: function (code, lang) {
      return hljs.highlightAuto(code, [lang]).value
    }
  });

  var html_content = marked( md_content )
  $('.article-body-markdown').html(html_content)
}

showMarkdown();

$('.article-body-form').bind('input propertychange', () => {
  showMarkdown()
})
