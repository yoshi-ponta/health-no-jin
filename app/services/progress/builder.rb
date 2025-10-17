module Progress
  class Builder
    def self.call(group, stage_limits: CastleHelper::CASTLE_LEVELS)
      total   = group.total_points
      limits  = Array(stage_limits).map(&:to_i).uniq.sort

      percent = Mapper.call(total_points: total, stage_limits: limits)[:progress_percent]

      Dto.new(total_points: total, progress_percent: percent, stage_limits: limits)
    end
  end
end
