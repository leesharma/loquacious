class ChatRoomMembershipsController < ApplicationController
  before_action :authenticate_user!

  # POST /global/join
  def create
    @room = ChatRoom.find_by_name params[:room]
    redirect_to new_chat_room_path, notice: 'Room not found' unless @room.present?

    current_user.join params[:room]
    redirect_to dashboard_path(room: params[:room])
  end
end
