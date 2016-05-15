require 'rails_helper'

feature 'Users can sign out', type: :feature do
  scenario 'with the log out button' do
    freddy = create(:user, username: 'freddy', password: 'password')
    # TODO: why can't this be accessed? login_as freddy

    # Signin
    visit login_path
    within 'form#new_session' do
      fill_in 'Username', with: 'freddy'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    click_link 'Log out'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Login'
    expect(page).to have_content 'Sign up'
  end
end
