var form = $('.article-body-form')
var markdown = $('.article-body-markdown')

form.scroll(function() {
  markdown.scrollTop(form.scrollTop() * markdown.get(0).scrollHeight/(form.get(0).scrollHeight));//縦スクロールを連動させる。
  markdown.scrollLeft(form.scrollLeft());//横スクロールを連動させる。
});