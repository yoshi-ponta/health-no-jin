class InvitesController < ApplicationController
  before_action :set_group
  before_action :authenticate_user!, only: :accept

  MAX_MEMBERS = 5

  def show
  end

  def accept
    if @group.users.exists?(current_user.id)
      redirect_to @group, notice: "すでにメンバーです" and return
    end

    if @group.users.count >= MAX_MEMBERS
      redirect_to invite_path(token: params[:token]), alert: "満員です" and return
    end

    @group.group_memberships.create!(user: current_user, joined_at: Time.current)

    redirect_to @group, notice: "グループに参加しました"

  rescue ActiveRecord::RecordNotUnique
    redirect_to @group, notice: "すでにメンバーです"
  end

  private

  def set_group
    @group = Group.find_by(invite_token: params[:token])
    redirect_to root_path, alert: "招待リンクが無効です" unless @group
  end
end
