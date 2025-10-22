class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def update
    user = current_user
    user.name = params[:name]
    user.introduction = params[:introduction]

    if user.save
      redirect_to edit_mypage_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = user.errors.full_messages.to_sentence
      render "mypages/edit", status: :unprocessable_entity
    end
  end
end
