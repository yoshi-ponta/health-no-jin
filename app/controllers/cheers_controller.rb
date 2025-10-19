class CheersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    to_user = User.find(params[:to_user_id])

    Cheer.find_or_create_by!(group: @group, from_user: current_user, to_user: to_user)

  rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
  ensure
    redirect_back fallback_location: group_path(@group)
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end
end
