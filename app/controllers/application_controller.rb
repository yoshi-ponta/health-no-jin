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

  def after_sign_in_path_for(resource)
    if (token = session.delete(:pending_invite_token)).present?
      invite_path(token: token)
    else
      super
    end
  end
end
