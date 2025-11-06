class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @memberships = @user.group_memberships.includes(:group)
  end

  def edit
    @user = current_user
    @memberships = current_user.group_memberships.active.includes(:group)
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
