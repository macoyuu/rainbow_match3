class UsersController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index]

def index
  @users = User.where.not(id: current_user.id)
end

def show
end

def edit
end

def update
  if @user.update(user_params)
    redirect_to user_path
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @user.destroy
  redirect_to root_path
end


private

def set_item
  @user = User.find(params[:id])
end

def ensure_correct_user
  if @user.id != current_user.id
    redirect_to root_path
  end
end

def user_params
  params.require(:user).permit(:nickname, :prefecture_id, :gender_identity_id, :sexual_orientation_1_id, 
  :sexual_orientation_2_id,:sexual_orientation_3_id,:sexual_orientation_4_id,
  :sexual_orientation_5_id, :sexual_orientation_6_id, :sexual_orientation_7_id,
  :height, :body_type_id, :purpose_id, :self_pr, :image)
end

end
