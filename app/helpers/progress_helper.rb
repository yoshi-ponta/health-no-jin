module ProgressHelper
  class ProgressBar
    include ActionView::Helpers::NumberHelper

    def initialize(progress)
      @progress = progress
    end

    def percent
      @progress.progress_percent
    end

    def total_points_label
      "#{number_with_delimiter(@progress.total_points)} pt"
    end

    def stage_bounds
      limits = @progress.stage_limits
      i = limits.rindex { |t| @progress.total_points >= t } || 0
      [ limits[i], limits[i + 1] ]
    end

    def start_label
      "#{stage_bounds.first} pt"
    end

    def end_label
      last = stage_bounds.last
      last.nil? ? "MAX" : "#{last} pt"
    end
  end

  def progress_bar(progress)
    ProgressBar.new(progress)
  end
end
