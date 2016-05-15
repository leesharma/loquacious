# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  after_create :join_default_rooms

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false }

  has_many :chat_room_memberships, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_memberships
  has_many :messages

  def join(chatroom, klass: ChatRoom)
    room = klass.find_by_name chatroom
    chat_rooms << room
    save
  end

  def chat_room_names
    chat_rooms.pluck(:name)
  end

  private

  def join_default_rooms(klass: ChatRoom, default_rooms: %w(global))
    klass.initialize_default_rooms
    default_rooms.each { |room| join room }
  end
end
