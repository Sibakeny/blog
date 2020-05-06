module AuthenticationHelper
    def login(user)
        visit session_path
        expect(page).to have_content 'Email'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'commit'
        expect(page).to have_content '記事一覧'
        expect(page).to have_content 'カテゴリ一覧'
    end
end