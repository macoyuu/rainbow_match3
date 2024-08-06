class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = current_user.chat_rooms
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.includes(:user)
  end

  def create
  end

end
