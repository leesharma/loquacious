class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def index
    @rooms = ChatRoomDecorator.decorate_collection current_user.chat_rooms
    @active_room = ChatRoomDecorator.decorate(active_room, url_param: params[:room])
    render layout: 'nospace'
  end

  # GET /rooms
  def new
    @rooms = ChatRoomDecorator.decorate_collection current_user.chat_rooms
    @available_rooms = ChatRoomDecorator.decorate_collection(
      ChatRoom.all - current_user.chat_rooms,
    )
    @room = ChatRoom.new
  end

  # POST /rooms/join
  def create
    @room = ChatRoom.new secure_params
    if @room.save
      current_user.join(@room.name)
      redirect_to dashboard_path(room: @room.name)
    else
      render :new
    end
  end

  private

  # Returns a hash of safe chat room attributes to prevent mass assignment attacks
  # @return [Hash] secure chat room parameters
  def secure_params
    params.require(:chat_room).permit(:name, :tagline)
  end

  # Returns the active chat room
  # @return [ChatRoom]
  def active_room
    ChatRoom.find_by_name(params[:room]) || current_user.chat_rooms.first
  end
end
