require 'rails_helper'

feature 'Guests can sign up', type: :feature do
  scenario 'with valid credentials' do
    visit root_url
    click_link 'Sign up'
    within 'form#new_user' do
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Create account'
    end

    expect(page).to have_text 'Hey foobar, welcome to loquacio.us!'
    expect(page).to have_link 'Log out'
    expect(current_path).to eq dashboard_path
  end

  scenario 'with a duplicate email' do
    create(:user, email: 'foo@example.com')
    visit root_url
    click_link 'Sign up'
    within 'form#new_user' do
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Create account'
    end

    expect(current_path).to eq sign_up_path
    expect(page).to have_content 'has already been taken'
    expect(page).not_to have_link 'Log out'
  end

  scenario 'with a duplicate username' do
    create(:user, username: 'foobar')
    visit root_url
    click_link 'Sign up'
    within 'form#new_user' do
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Create account'
    end

    expect(current_path).to eq sign_up_path
    expect(page).to have_content 'has already been taken'
    expect(page).not_to have_link 'Log out'
  end

  scenario 'without a password' do
    visit root_url
    click_link 'Sign up'
    within 'form#new_user' do
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Username', with: 'foobar'
      click_button 'Create account'
    end

    expect(current_path).to eq sign_up_path
    expect(page).to have_content "can't be blank"
    expect(page).not_to have_link 'Log out'
  end

  scenario 'and sees a default chatroom' do
    visit root_url
    click_link 'Sign up'
    within 'form#new_user' do
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Username', with: 'foobar'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Create account'
    end

    expect(page).to have_text 'Hey foobar, welcome to loquacio.us!'
    expect(page).to have_link 'Log out'
  end
end
