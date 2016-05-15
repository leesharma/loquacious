require 'rails_helper'

feature 'Users can join chatrooms', type: :feature do
  context 'that already exist' do
    scenario 'from the chat rooms page' do
      maria = create(:user, password: 'password')
      create(:chat_room, name: 'scheme')

      visit login_path
      within 'form' do
        fill_in 'Username', with: maria.username
        fill_in 'Password', with: maria.password
        click_button 'Login'
      end

      click_link 'add room'
      click_button 'Join'

      expect(current_path).to eq dashboard_path(room: 'scheme')
      expect(page).to have_content 'scheme'
      expect(maria.reload.chat_room_names).to include 'scheme'
    end

    scenario 'by visiting their page' do
      maria = create(:user, password: 'password')
      create(:chat_room, name: 'scheme')

      visit login_path
      within 'form' do
        fill_in 'Username', with: maria.username
        fill_in 'Password', with: maria.password
        click_button 'Login'
      end

      click_link 'add room'
      click_link 'scheme'
      click_button 'Join'

      expect(current_path).to eq dashboard_path(room: 'scheme')
      expect(page).to have_content 'scheme'
      expect(maria.reload.chat_room_names).to include 'scheme'
    end
  end

  context "that don't yet exist" do
    scenario 'from the chat rooms page' do
      maria = create(:user, password: 'password')

      visit login_path
      within 'form' do
        fill_in 'Username', with: maria.username
        fill_in 'Password', with: maria.password
        click_button 'Login'
      end

      click_link 'add room'

      within 'form#new_chat_room' do
        fill_in 'Name', with: 'scheme'
        fill_in 'Tagline', with: 'slides down easily'
        click_button 'Create room'
      end

      expect(current_path).to eq dashboard_path(room: 'scheme')
      expect(page).to have_content 'scheme'
      expect(maria.reload.chat_room_names).to include 'scheme'
    end
  end
end
