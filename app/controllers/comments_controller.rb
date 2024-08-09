class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :create]

  def index
    if current_user.matched_with?(@user)
      @comments = Comment.between_users(current_user, @user)
      @comment = Comment.new
    else
      redirect_to root_path, alert: "アクセス権限がありません。"
    end
  end

  def create
    @comment = current_user.from_comments.build(comment_params)
    @comment.to_user = @user
    if @comment.save
      redirect_to user_comments_path(@user), notice: "コメントが送信されました。"
    else
      @comments = Comment.between_users(current_user, @user)
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :to_user_id)
  end
end