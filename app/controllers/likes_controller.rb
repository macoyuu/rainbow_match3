class LikesController < ApplicationController
  before_action :set_user

  def create
    like = current_user.likes.build(to_user_id: @user.id) # 外部キーの指定を修正
    if like.save
      like.check_matching # 状態が更新された後にコールバックを実行
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    like = Like.find_by(to_user_id: @user.id, from_user_id: current_user.id)
    like&.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
