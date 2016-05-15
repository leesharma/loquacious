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

class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :chat_room_memberships, dependent: :destroy
  has_many :users, through: :chat_room_memberships

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 16 },
                   format: { with: /\A[a-z0-9\-_]+\z/,
                             message: 'only alphanumeric characters, -, and _ permitted' }
  validates :tagline, length: { maximum: 32 }

  class << self
    # @param name [String] chat room name
    # @return [ChatRoom, nil]
    def find_by_name(name)
      where(name: name.to_s).first
    end

    # @return [ChatRoom] the global chat room
    def global
      @global = @global or
                find_by_name('global') or
                create(name: 'global', tagline: 'Everyone lives here.')
    end
    alias_method :initialize_default_rooms, :global
  end

  def includes_user?(user)
    users.include? user
  end
end
