module CastleHelper
  CASTLE_LEVELS = [ 0, 50, 150, 300, 500 ].freeze

  IMAGE_BASENAME = "castles/castle%d.png"

  def castle_image_path_for(total_points)
    points = [ total_points.to_i, 0 ].max
    level = CASTLE_LEVELS.count { |lv| points >= lv }
    max_level = CASTLE_LEVELS.length
    level = [ [ level, 1 ].max, max_level ].min
    format(IMAGE_BASENAME, level)
  end
end
