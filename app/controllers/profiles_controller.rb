class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user

    if params.dig(:user, :remove_avatar) == "1" && @user.avatar.attached?
      @user.avatar.purge_later
    end

    if @user.update(user_params)
      redirect_to edit_mypage_path, notice: "プロフィールを更新しました"
    else
      @memberships = @user.group_memberships.includes(:group)
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render "mypages/edit", status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
