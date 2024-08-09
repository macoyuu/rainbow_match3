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


end
end