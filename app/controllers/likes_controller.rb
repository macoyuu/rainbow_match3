class LikesController < ApplicationController
before_action :set_user

def create
  like = current_user.likes.build(to_user_id: @user.id) # 外部キーの指定を修正

  if like.save
    # マッチングが成立したかどうか確認
    from_user = current_user
    to_user = @user

    if Like.exists?(from_user: to_user, to_user: from_user)
      # マッチングが成立した場合、チャットルームを作成
      match_users(from_user, to_user)
    end

    respond_to do |format|
      format.js { render :create }  # JavaScript用のレスポンス
      format.html { redirect_to user_path(@user.id), notice: "いいね！しました" }
    end

  else
    respond_to do |format|
      format.js { render :error }  # エラー時のJavaScript用のレスポンス
      format.html { redirect_to user_path(@user.id), alert: "いいね！に失敗しました" }
    end
  end
end

def destroy
  like = Like.find_by(to_user_id: @user.id, from_user_id: current_user.id)
  like&.destroy

  respond_to do |format|
    format.js { render :destroy }  # JavaScript用のレスポンス
    format.html { redirect_to user_path(@user.id), notice: "解除しました" }
  end
end

private

def set_user
  @user = User.find(params[:user_id])
end

def match_users(user1, user2)
  chat_room = ChatRoom.joins(:chat_room_users)
                      .where(chat_room_users: { user_id: [user1.id, user2.id] })
                      .group(:id)
                      .having('COUNT(chat_room_users.id) = 2')
                      .first

  # 既存のチャットルームがない場合、新しく作成
  unless chat_room
    chat_room = ChatRoom.create
    if chat_room.persisted?
      ChatRoomUser.create(chat_room: chat_room, user: user1)
      ChatRoomUser.create(chat_room: chat_room, user: user2)
    else
      # エラー処理 (例: ログに出力)
      Rails.logger.error "チャットルームの作成に失敗しました: #{chat_room.errors.full_messages.join(", ")}"
    end

  chat_room
 end
end
end