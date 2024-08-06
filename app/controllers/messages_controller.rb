class MessagesController < ApplicationController
    def index
      @chat_room = ChatRoom.find(params[:chat_room_id])
      @messages = @chat_room.messages.includes(:user) # 既存のメッセージ一覧を取得
      @message = Message.new
    end
  
    def create
      @chat_room = ChatRoom.find(params[:chat_room_id])
      @message = @chat_room.messages.new(message_params)
  
      if @message.save
        redirect_to chat_room_path(@chat_room), notice: 'メッセージが送信されました'
      else
        @messages = @chat_room.messages.includes(:user)
        render :index, alert: 'メッセージの送信に失敗しました'
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:content).merge(user_id: current_user.id)
    end
  end
