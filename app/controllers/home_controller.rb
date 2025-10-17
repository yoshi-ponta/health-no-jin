class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_group = current_user.groups.first
    if @active_group.present?
      @progress = @active_group
    end
  end
end
