class LikesController < ApplicationController
  before_action :set_user
  
  def create
    like = current_user.likes.build(to_user_id: params[:user_id]) # 外部キーの指定を修正
    like.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    like = Like.find_by(to_user_id: params[:user_id], from_user_id: current_user.id)
    like&.destroy
    respond_to do |format|
      format.js
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
