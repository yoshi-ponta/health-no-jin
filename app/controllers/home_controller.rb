class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @group_total_points =
      if @active_group
        @active_group.total_points
      else
        0
      end
  end
end
