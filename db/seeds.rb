ActiveRecord::Base.transaction do
  items = [
    { name: "ウォーキング", base_points: 5 },
    { name: "ジョギング",   base_points: 8 },
    { name: "縄跳び",       base_points: 10 },
    { name: "階段",         base_points: 4 },
    { name: "腕立て",       base_points: 3 },
    { name: "スクワット",   base_points: 2 },
    { name: "腹筋",         base_points: 3 },
    { name: "背筋",         base_points: 4 }
  ]

  items.each do |attrs|
    ExerciseItem.find_or_initialize_by(name: attrs[:name]).update!(base_points: attrs[:base_points])
  end
end
