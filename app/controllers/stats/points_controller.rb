module Stats
  class PointsController < ApplicationController
    before_action :authenticate_user!

    def daily
      days  = params[:days].presence&.to_i || 30
      days  = [ days, 1 ].max
      today = Time.zone.today
      from  = today.beginning_of_month
      to    = [ from.end_of_month, from + (days - 1) ].min

      rows = current_user.exercise_logs
        .where(performed_at: from.beginning_of_day..to.end_of_day)
        .group("DATE(performed_at)")
        .sum(:points)
        .transform_keys { |date| date.to_date }

      data = (from..to).map do |date|
        {
          date: date.strftime("%Y-%m-%d"),
          day: date.day,
          daily: rows[date] || 0
        }
      end

      render json: data
    end
  end
end
