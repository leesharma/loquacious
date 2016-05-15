require 'rails_helper'

feature 'Users can add messages', type: :feature do
  scenario 'from the default chatroom' do
    maria = create(:user, password: 'password')

    visit login_path
    within 'form' do
      fill_in 'Username', with: maria.username
      fill_in 'Password', with: maria.password
      click_button 'Login'
    end

    fill_in 'new_message', with: 'hello, world'
    click_button 'Send'

    within '.messages' do
      expect(page).to have_content 'hello, world'
    end
  end

  scenario 'with a blank message' do
    maria = create(:user, password: 'password')

    visit login_path
    within 'form' do
      fill_in 'Username', with: maria.username
      fill_in 'Password', with: maria.password
      click_button 'Login'
    end

    click_button 'Send'

    expect(current_path).to eq dashboard_path
    expect(find('#messages_container')).not_to have_content maria.username
  end

  scenario 'from a non-default chatroom' do
    maria = create(:user, password: 'password')
    maria.chat_rooms << create(:chat_room, name: 'haskell')
    maria.save

    visit login_path
    within 'form' do
      fill_in 'Username', with: maria.username
      fill_in 'Password', with: maria.password
      click_button 'Login'
    end

    click_link 'haskell'
    fill_in 'new_message', with: 'hello, world'
    click_button 'Send'

    expect(current_path).to eq dashboard_path(room: 'haskell')
    within '.messages' do
      expect(page).to have_content 'hello, world'
    end
  end
end
