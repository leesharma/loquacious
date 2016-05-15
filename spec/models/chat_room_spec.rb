# == Schema Information
#
# Table name: chat_rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  tagline    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ChatRoom, :type => :model do
  describe 'factory' do
    it 'should be valid' do
      room = build(:chat_room)
      expect(room).to be_valid
    end
  end

  describe 'a valid chat room' do
    describe 'a valid name' do
      it 'is present' do
        room = build(:chat_room, name: nil)
        expect(room).not_to be_valid
      end

      it 'is unique' do
        create(:chat_room, name: 'dup')
        room = build(:chat_room, name: 'dup')
        expect(room).not_to be_valid
      end

      it 'must be shorter than 16 characters' do
        room = build(:chat_room, name: 'a' * 17)
        expect(room).not_to be_valid
        room.name = 'a' * 16
        expect(room).to be_valid
      end

      it 'allows lower alphanumeric characters, dashes, and underscores' do
        room = build(:chat_room, name: 'abc123-_')
        expect(room).to be_valid
      end

      it 'prohibits capital letters' do
        room = build(:chat_room, name: 'ABC')
        expect(room).not_to be_valid
      end

      it 'prohibits special characters' do
        room = build(:chat_room, name: '#abc')
        expect(room).not_to be_valid
      end
    end

    describe 'a valid tagline' do
      it 'is shorter than 32 characters' do
        room = build(:chat_room, tagline: 'a' * 33)
        expect(room).not_to be_valid
        room.tagline = 'a' * 32
        expect(room).to be_valid
      end
    end
  end

  describe 'scope .find_by_name' do
    it 'finds a chat room by name' do
      erlang = create(:chat_room, name: 'erlang')
      found_room = ChatRoom.find_by_name 'erlang'
      expect(found_room).to eq erlang
    end
  end

  describe '.global' do
    it 'finds the global chatroom if one exists' do
      created = create(:chat_room, name: 'global')
      expect { ChatRoom.global }.not_to change { ChatRoom.count }
      returned = ChatRoom.global
      expect(returned).to eq created
    end

    it 'creates a new global chatroom if none exist' do
      expect { ChatRoom.global }.to change { ChatRoom.count }
    end
  end
end
