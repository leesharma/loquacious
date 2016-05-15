require 'rails_helper'

feature 'Users can sign in', type: :feature do
  scenario 'with valid credentials' do
    create(:user, username: 'foobar', password: 'password')
    visit root_url
    click_link 'Login'
    within 'form#new_session' do
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    expect(page).to have_link 'Log out'
    expect(current_path).to eq dashboard_path
  end

  scenario 'with a differently-cased username' do
    create(:user, username: 'foobar', password: 'password')
    visit root_url
    click_link 'Login'
    within 'form#new_session' do
      fill_in 'Username', with: 'FOOBAR'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    expect(page).to have_link 'Log out'
  end

  # TODO: error messages

  scenario 'without a password' do
    visit root_url
    click_link 'Login'
    within 'form#new_session' do
      fill_in 'Username', with: 'foobar'
      click_button 'Login'
    end

    expect(current_path).to eq login_path
    expect(page).not_to have_link 'Log out'
  end

  scenario 'with invalid credentials' do
    create(:user, username: 'foobar', password: 'password')
    visit root_url
    click_link 'Login'
    within 'form#new_session' do
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'not the password'
      click_button 'Login'
    end

    expect(current_path).to eq login_path
    expect(page).not_to have_link 'Log out'
  end
end
