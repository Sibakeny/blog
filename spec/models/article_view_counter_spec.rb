require 'rails_helper'

RSpec.describe ArticleViewCounter, type: :model do
  describe 'カウンター作成' do
    before do
      @article = create(:article)
    end
    it '作成できること' do
      counter = @article.article_view_counters.new()
      expect(counter).to be_valid
    end
  end
end
