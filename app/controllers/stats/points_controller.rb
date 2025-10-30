module Stats
  class PointsController < ApplicationController
    before_action :authenticate_user!

    def daily
      days = params[:days].presence&.to_i || 30
      from = days.days.ago.to_date
      to   = Date.today

      rows = current_user.exercise_logs
        .where(performed_at: from.beginning_of_day..to.end_of_day)
        .group("DATE(performed_at)")
        .sum(:points)

      data = (from..to).map do |d|
        { date: d.strftime("%Y-%m-%d"), daily: rows[d] || 0 }
      end

      render json: data
    end
  end
end
