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
end
