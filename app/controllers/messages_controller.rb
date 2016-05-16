class MessagesController < ApplicationController
  before_action :authenticate_user!

  # POST /global/messages
  def create
    @message = Message.new secure_params
    if @message.save
      redirect_to dashboard_path(room: params[:room])
    else
      reset_ivars
      render 'chat_rooms/index', room: params[:room], layout: 'nospace'
    end
  end

  private

  # Returns a hash of attributes for the new message
  # @return [Hash]
  def secure_params
    { message: params[:new_message], user: current_user, chat_room: active_room }
  end

  # Resets the instance variables to be used in the rendered view
  def reset_ivars
    @rooms = ChatRoomDecorator.decorate_collection current_user.chat_rooms
    @active_room = ChatRoomDecorator.decorate active_room,
                                              url_param: params[:room]
  end

  # Returns the active chat room
  # @return [ChatRoom]
  def active_room
    ChatRoom.find_by_name(params[:room]) || current_user.chat_rooms.first
  end
end
