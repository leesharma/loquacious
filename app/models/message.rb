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

# TODO: move most of this to a presenter/decorator
class Message < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :user
  belongs_to :chat_room

  validates :message, presence: true

  def username
    user.username
  end

  def time
    "#{time_ago_in_words updated_at} ago"
  end

  def username_style
    user == current_user ? 'you' : username
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
