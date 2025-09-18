ActiveRecord::Base.transaction do
  [
    { name: "歩く", base_points: 1 },
    { name: "ストレッチ", base_points: 1 },
    { name: "走る", base_points: 2 },
    { name: "筋トレ", base_points: 3 },
    # 追加の運動項目があればここに追記
  ].each do |attrs|
    ExerciseItem.find_or_create_by(name: attrs[:name]) do |item|
      item.base_points = attrs[:base_points]
    end
  end

  puts "[seed] ExerciseItem count: #{ExerciseItem.count}"
end
