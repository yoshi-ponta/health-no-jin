class ApplicationController < ActionController::Base
  before_action :set_active_group

  private
  def set_active_group
    return unless current_user

    gid = session[:active_group_id]
    @active_group =
      if gid.present?
        current_user.groups.find_by(id: gid)
      else
        current_user.groups
          .joins(:group_memberships)
          .where(group_memberships: { left_at: nil })
          .first
      end
  end
end
