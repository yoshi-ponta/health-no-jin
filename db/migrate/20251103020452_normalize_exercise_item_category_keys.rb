class NormalizeExerciseItemCategoryKeys < ActiveRecord::Migration[8.0]
  MAP = {
    "有酸素運動"           => "running",
    "有酸素運動（高強度）" => "running2",
    "筋トレ"               => "pushup",
    "筋トレ（高強度）"     => "pushup2",
    "ストレッチ"           => "stretch",
    "ストレッチ2"          => "stretch2",
    "暮らしの活動"         => "daily",
    "セルフケア"           => "recovery",
    "スポーツ"             => "sports",
  }.freeze

  def up
    MAP.each do |from, to|
      ExerciseItem.where(category: from).update_all(category: to, updated_at: Time.current)
    end
  end

  def down
    MAP.invert.each do |from, to|
      ExerciseItem.where(category: from).update_all(category: to, updated_at: Time.current)
    end
  end
end
