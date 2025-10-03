class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups.joins(:group_memberships).where(group_memberships: { left_at: nil }).order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def show
    @group = current_user.groups.find(params[:id])
  end

  def create
  @group = Group.new(group_params.merge(owner_id: current_user.id))
  if @group.save
    current_user.group_memberships.create!(group: @group, joined_at: Time.current, left_at: nil)
    session[:active_group_id] = @group.id
    redirect_to authenticated_root_path, notice: "「#{@group.name}」を作成しました。", status: :see_other
  else
    render :new, status: :unprocessable_entity
  end
end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
