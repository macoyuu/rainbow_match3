class CommentsController < ApplicationController
  before_action :set_user
  #before_action :check_matching, only: [:index, :create]

  def index
    @comments = Comment.where(to_user: @user)
    @comment = Comment.new  # 新しいコメントオブジェクトを初期化
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.from_user = current_user
    @comment.to_user = @user

  def show
    @comment = Comment.new
    @comments = @user.comments.includes(:user)
  end

    if @comment.save
      redirect_to user_comments_path(@user), notice: 'コメントが投稿されました。'
    else
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  #def check_matching
    #like = Like.find_by(user: current_user, liked_user: @user, mutual: true)

   # unless like
      #redirect_to root_path, alert: 'このユーザーとマッチングしていません。'
    #end
 # end

  def comment_params
    params.require(:comment).permit(:text)
  end
end