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

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :message, presence: true

  # Returns the username associated with the message
  # @return [String] username
  def username
    user.username
  end
end
