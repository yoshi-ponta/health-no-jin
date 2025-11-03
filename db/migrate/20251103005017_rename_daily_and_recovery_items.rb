class RenameDailyAndRecoveryItems < ActiveRecord::Migration[8.0]
  def up
    ActiveRecord::Base.transaction do
      ExerciseItem.where(category: "日常の運動").update_all(category: "暮らしの活動", updated_at: Time.current)
      map = {
        "cleaning"         => { detail_key: "housework",        name: "家事" },
        "taking_out_trash" => { detail_key: "shopping_outing",  name: "買い物・外出" },
        "laundry"          => { detail_key: "work_activity",    name: "仕事" },
        "cooking"          => { detail_key: "hydration",        name: "水分補給" },
      }
      map.each do |from_key, to|
        tmp = "__renaming__#{from_key}"
        ExerciseItem.where(category: "暮らしの活動", detail_key: from_key).update_all(detail_key: tmp, updated_at: Time.current)
        ExerciseItem.where(category: "暮らしの活動", detail_key: tmp).update_all(detail_key: to[:detail_key], name: to[:name], base_points: 3, updated_at: Time.current)
      end

      ExerciseItem.where(category: "セルフケア", detail_key: "hot_spring").update_all(name: "半身浴", updated_at: Time.current)
    end
  end

  def down
    ActiveRecord::Base.transaction do
      ExerciseItem.where(category: "セルフケア", detail_key: "hot_spring").update_all(name: "温泉", updated_at: Time.current)
      rev_map = {
        "housework"        => { detail_key: "cleaning",         name: "掃除" },
        "shopping_outing"  => { detail_key: "taking_out_trash", name: "ゴミ出し" },
        "work_activity"    => { detail_key: "laundry",          name: "洗濯干し" },
        "hydration"        => { detail_key: "cooking",          name: "料理" },
      }

      rev_map.each do |from_key, to|
        tmp = "__renaming__#{from_key}"
        ExerciseItem.where(category: "暮らしの活動", detail_key: from_key).update_all(detail_key: tmp, updated_at: Time.current)
        ExerciseItem.where(category: "暮らしの活動", detail_key: tmp).update_all(detail_key: to[:detail_key], name: to[:name], base_points: 3, updated_at: Time.current)
      end

      ExerciseItem.where(category: "暮らしの活動")
                  .update_all(category: "日常の運動", updated_at: Time.current)
    end
  end
end
