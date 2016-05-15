# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  chat_room_id :integer
#  message      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Message, type: :model do
  describe 'factory' do
    it 'is valid' do
      message = build(:message)
      expect(message).to be_valid
    end
  end

  describe 'a valid message' do
    it 'requires a message' do
      message = build(:message, message: nil)
      expect(message).to be_invalid
    end

    it 'requires a chat room' do
      message = build(:message, chat_room: nil)
      expect(message).to be_invalid
    end
  end
end
