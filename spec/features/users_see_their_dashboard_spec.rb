require 'rails_helper'

feature 'Users see their dashboards', type: :feature do
  scenario 'a users joins the #general channel by default' do
    monica = create(:user, password: 'password')
    visit login_path
    within 'form' do
      fill_in 'Username', with: monica.username
      fill_in 'Password', with: monica.password
      click_button 'Login'
    end

    expect(page).to have_css '.chatroom#global'
    expect(page).to have_content 'global'
  end

  scenario 'including all of their chat rooms' do
    maria = create(:user, password: 'password')
    maria.chat_rooms << create(:chat_room, name: 'elixer')
    maria.chat_rooms << create(:chat_room, name: 'phoenix')

    visit login_path
    within 'form' do
      fill_in 'Username', with: maria.username
      fill_in 'Password', with: maria.password
      click_button 'Login'
    end

    expect(page).to have_content 'global'
    expect(page).to have_content 'elixer'
    expect(page).to have_content 'phoenix'
  end

  scenario 'including the messages from the active room' do
    jerome = create(:user, password: 'password')
    create(:message, user: jerome, message: 'hello, world', chat_room: ChatRoom.global)

    visit login_path
    within 'form' do
      fill_in 'Username', with: jerome.username
      fill_in 'Password', with: jerome.password
      click_button 'Login'
    end

    expect(page).to have_content 'hello, world'
  end

  scenario 'and can switch active chatrooms' do
    maria = create(:user, password: 'password')
    maria.chat_rooms << create(:chat_room, name: 'elixer')
    create(:message,
           user: maria,
           message: 'hello, world',
           chat_room: ChatRoom.find_by_name('elixer'))

    visit login_path
    within 'form' do
      fill_in 'Username', with: maria.username
      fill_in 'Password', with: maria.password
      click_button 'Login'
    end

    click_link 'elixer'
    expect(page).to have_content 'hello, world'
  end
end
