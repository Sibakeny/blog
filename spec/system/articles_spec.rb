require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  before do
    @user = create(:user)
    create(:article, title: 'first_article')
    create(:article, title: 'second_article')
  end

  it 'completes yubinbango automatically with JS' do
    login(@user)
    visit articles_path

    expect(page).to have_content 'first_article'
    expect(page).to have_content 'second_article'
  end
end