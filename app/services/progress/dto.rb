module Progress
  class Dto
    attr_reader :total_points, :progress_percent, :stage_limits

    def initialize(total_points:, progress_percent:, stage_limits: [])
      @total_points = total_points.to_i
      @total_points = 0 if @total_points.negative?

      @progress_percent = progress_percent.to_i.clamp(0, 100)

      limits = Array(stage_limits).map(&:to_i)
      limits = [ 0 ] if limits.empty?
      @stage_limits = limits.uniq.sort.freeze
    end
  end
end
