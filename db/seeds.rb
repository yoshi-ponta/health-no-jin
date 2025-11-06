categories = [

  { key: :running, name: "有酸素運動", icon: "🚶‍♂️‍➡️", items: [
    { name: "散歩",       detail_key: "walking",      base_points: 3 },
    { name: "体操",       detail_key: "calisthenics", base_points: 4 },
    { name: "階段昇降",   detail_key: "stair_climb",  base_points: 5 },
    { name: "ジョギング", detail_key: "jogging",      base_points: 6 }
  ] },

  { key: :running2, name: "有酸素運動（高強度）", icon: "🏃", items: [
    { name: "サイクリング",     detail_key: "cycling",   base_points: 7 },
    { name: "縄跳び",           detail_key: "jump_rope", base_points: 8 },
    { name: "ダンス",       detail_key: "running",   base_points: 9 },
    { name: "HIITトレーニング", detail_key: "hiit",      base_points: 10 }
  ] },

  { key: :pushup, name: "筋トレ", icon: "💪", items: [
    { name: "スクワット", detail_key: "squat",           base_points: 6 },
    { name: "腕立て",     detail_key: "pushup",          base_points: 7 },
    { name: "腹筋",       detail_key: "situp",           base_points: 8 },
    { name: "背筋",       detail_key: "back_extension",  base_points: 9 }
  ] },

  { key: :pushup2, name: "筋トレ（高強度）", icon: "🏋️", items: [
    { name: "スクワット（30回以上）", detail_key: "squat_hard",  base_points: 10 },
    { name: "腹筋（15回以上）",       detail_key: "situp_hard",   base_points: 12 },
    { name: "腕立て（10回以上）",     detail_key: "pushup_hard", base_points: 12 },
    { name: "懸垂（5回以上）",         detail_key: "pullup",       base_points: 15 }
  ] },

  { key: :stretch, name: "ストレッチ", icon: "🧘‍♀️", items: [
    { name: "肩回し", detail_key: "shoulder_roll", base_points: 2 },
    { name: "首回し", detail_key: "neck_roll",     base_points: 2 },
    { name: "背伸び", detail_key: "stretch_up",    base_points: 2 },
    { name: "前屈",   detail_key: "forward_bend", base_points: 3 }
  ] },

  { key: :stretch2, name: "ストレッチ2", icon: "🧘", items: [
    { name: "アキレス腱伸ばし", detail_key: "achilles_stretch", base_points: 3 },
    { name: "もも前伸ばし",     detail_key: "thigh_stretch",     base_points: 3 },
    { name: "股関節ストレッチ", detail_key: "hip_stretch",       base_points: 4 },
    { name: "腰のストレッチ",         detail_key: "waist_twist",       base_points: 4 }
  ] },

  { key: :daily, name: "暮らしの活動", icon: "🧹", items: [
  { name: "家事",       detail_key: "housework",  base_points: 3 },
  { name: "買い物・外出", detail_key: "shopping_outing", base_points: 3 },
  { name: "仕事",       detail_key: "work_activity", base_points: 3 },
  { name: "水分補給",   detail_key: "hydration",  base_points: 3 }
  ] },

  { key: :recovery, name: "セルフケア", icon: "💆‍♂️", items: [
    { name: "深呼吸",     detail_key: "deep_breathing", base_points: 6 },
    { name: "マッサージ", detail_key: "massage",        base_points: 7 },
    { name: "半身浴",       detail_key: "hot_spring",     base_points: 8 },
    { name: "ヨガ",       detail_key: "yoga",           base_points: 10 }
  ] },

  { key: :sports, name: "スポーツ", icon: "🏊‍♀️", items: [
    { name: "球技",           detail_key: "ball_sports",  base_points: 20 },
    { name: "水泳",           detail_key: "swimming",     base_points: 20 },
    { name: "ジムトレーニング", detail_key: "gym_training", base_points: 20 },
    { name: "マラソン",       detail_key: "marathon",     base_points: 20 }
  ] }
]

categories.each do |cat|
  cat[:items].each do |it|
    item = ExerciseItem.find_or_initialize_by(category: cat[:key].to_s, detail_key: it[:detail_key])
    item.category    = cat[:key].to_s
    item.icon        = cat[:icon]
    item.name        = it[:name]
    item.base_points = it[:base_points]
    item.save!
  end
end
