class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_group!, only: [ :index ]

  def index
    @group = current_user.groups
      .joins(:group_memberships)
      .where(group_memberships: { user_id: current_user.id, left_at: nil })
      .limit(1)
      .first

    if @group
      @members = @group.group_memberships
        .preload(:user)
        .where(left_at: nil)
        .order(
          Arel.sql("(group_memberships.user_id = #{@group.owner_id}) DESC, group_memberships.joined_at ASC")
        )

      @points_by_user = ExerciseLog
      .joins(user: :group_memberships)
      .where(group_memberships: { group_id: @group.id })
      .where("exercise_logs.performed_at >= group_memberships.joined_at")
      .where("group_memberships.left_at IS NULL OR exercise_logs.performed_at < group_memberships.left_at")
      .group("group_memberships.user_id")
      .sum(:points)
    else
      @members = []
      @points_by_user = {}
    end
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
