module Progress
  class Mapper
    def self.call(total_points:, stage_limits:)
      total = Integer(total_points)
      limits = Array(stage_limits)

      idx = limits.rindex { |th| total >= th } || 0
      start_pt = limits[idx]
      end_pt   = limits[idx + 1]

      progress_percent =
        if end_pt.nil? || end_pt <= start_pt
          100
        else
          (((total - start_pt).to_f / (end_pt - start_pt)) * 100).floor.clamp(0, 100)
        end

      { progress_percent: progress_percent }
    end
  end
end
