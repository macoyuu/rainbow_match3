class LikesController < ApplicationController
  before_action :set_user

  def create
    like = current_user.likes.build(to_user_id: @user.id)

    if like.save
      # マッチングが成立したかどうか確認
      from_user = current_user
      to_user = @user

      if Like.exists?(from_user: to_user, to_user: from_user)
        # マッチングが成立した場合、チャットルームを作成
        match_users(from_user, to_user)
      else
        # 通常のLikeの場合、アクティビティを作成
        like.create_activity key: 'like.created', owner: from_user, recipient: to_user
      end

      respond_to do |format|
        format.js { render :create }
        format.html { redirect_to user_path(@user.id), notice: "いいね！しました" }
      end

    else
      respond_to do |format|
        format.js { render :error }
        format.html { redirect_to user_path(@user.id), alert: "いいね！に失敗しました" }
      end
    end
  end

  def destroy
    like = Like.find_by(to_user_id: @user.id, from_user_id: current_user.id)
    if like.present?
      like.destroy
      respond_to do |format|
        format.js { render :destroy }
        format.html { redirect_to user_path(@user.id), notice: "解除しました" }
      end
    else
      respond_to do |format|
        format.js { render :error }
        format.html { redirect_to user_path(@user.id), alert: "解除に失敗しました" }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def match_users(from_user, to_user)
    # マッチングが成立した時の処理をここに記述
    # 例: チャットルーム作成、通知送信など
  end
end