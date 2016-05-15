class MessagesController < ApplicationController
  before_action :authenticate_user!

  # POST /global/messages
  def create
    @message = Message.new secure_params
    if @message.save
      redirect_to dashboard_path(room: params[:room])
    else
      # re-set instance variables
      @rooms = current_user.chat_rooms
      @active_room = current_room
      @active_room_name = params[:room]
      render 'chat_rooms/index', room: params[:room], layout: 'nospace'
    end
  end

  private

  def secure_params
    { message: params[:new_message], user: current_user, chat_room: current_room }
  end

  def current_room
    ChatRoom.find_by_name(params[:room]) || ChatRoom.global
  end
end
