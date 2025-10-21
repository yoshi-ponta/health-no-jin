class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def destroy
    membership = current_user.group_memberships.find_by(group_id: @group.id, left_at: nil)
    if membership
      if @group.owner_id == current_user.id &&
          @group.group_memberships.where(left_at: nil).where.not(user_id: current_user.id).exists?
        redirect_to @group, alert: "グループリーダーはメンバーが在籍している間は退会できません。"
      else
        membership.update!(left_at: Time.current)
        session.delete(:active_group_id) if session[:active_group_id] == @group.id
        redirect_to groups_path, notice: "退会しました。"
      end
    else
      redirect_to @group, alert: "このグループには在籍していません。"
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end
end
