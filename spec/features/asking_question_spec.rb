require_relative 'features_helper'

feature 'Asking question' do
  context 'when signed in' do
    background { login_user }

    scenario 'user can add a question' do
      visit '/'
      click_link 'Ask question'

      fill_in 'Title', with: 'Some question title'
      fill_in 'Body', with: 'The body of question'
      click_button 'Post your question'

      expect(page).to have_content 'Some question title'
      expect(page).to have_content 'The body of question'
    end
  end

  context 'when not signed in' do
    scenario 'user redirected to login form' do
      visit '/'
      click_link 'Ask question'

      expect(page).to have_content 'You need to sign in'
    end
  end
end
