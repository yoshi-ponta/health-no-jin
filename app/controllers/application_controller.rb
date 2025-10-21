class ApplicationController < ActionController::Base
  before_action :set_active_group
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  private
  def set_active_group
    return unless current_user

    active_groups = current_user.groups
      .joins(:group_memberships)
      .where(group_memberships: { left_at: nil })
    gid = session[:active_group_id]
    if gid.present?
      @active_group = active_groups.find_by(id: gid)
      session.delete(:active_group_id) if @active_group.nil?
    end

    @active_group ||= active_groups.first
  end

  def require_active_group!
    return if @active_group.present?

    redirect_to authenticated_root_path, alert: "グループを作成または参加してください。" and return
  end

  def after_sign_in_path_for(resource)
    if (token = session.delete(:pending_invite_token)).present?
      invite_path(token: token)
    else
      super
    end
  end
end
