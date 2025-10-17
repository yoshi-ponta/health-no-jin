class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if @active_group
      @progress = Progress::Builder.call(@active_group)
    else
      @progress = Progress::Dto.new(total_points: 0, progress_percent: 0, stage_limits: CastleHelper::CASTLE_LEVELS)
    end
  end
end
