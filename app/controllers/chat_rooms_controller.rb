class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def index
    # TODO: reduce ivars
    @rooms = current_user.chat_rooms
    @active_room = set_active_room
    @active_room_name = params[:room]
    render layout: 'nospace'
  end

  # GET /rooms/join
  def new
    @rooms = ChatRoom.all - current_user.chat_rooms
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

  def secure_params
    params.require(:chat_room).permit(:name, :tagline)
  end

  def set_active_room
    ChatRoom.find_by_name(params[:room]) || current_user.chat_rooms.first
  end
end
