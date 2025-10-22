class MypagesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @memberships = current_user.group_memberships.active.includes(:group)
  end
end
