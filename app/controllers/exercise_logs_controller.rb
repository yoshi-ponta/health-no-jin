class ExerciseLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_group!

  def index
  end

  def new
    @exercise_log = ExerciseLog.new(performed_at: Time.zone.now, amount: 1)
    @exercise_categories = exercise_categories
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)
    @exercise_log.group = @active_group

    if @exercise_log.save
      redirect_to new_exercise_log_path, notice: "記録しました"
    else
      @exercise_categories = exercise_categories
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def exercise_log_params
    params.require(:exercise_log)
          .permit(:exercise_item_id, :amount, :performed_at)
  end

  def exercise_categories
    categories = [
      { key: :running, name: "有酸素運動", icon: "🏃‍♂️", items: [
          { name: "ウォーキング", detail_key: "walking" },
          { name: "ジョギング",   detail_key: "jogging" },
          { name: "縄跳び",       detail_key: "jump_rope" },
          { name: "階段",         detail_key: "stairs" }
        ] },
      { key: :pushup, name: "筋トレ", icon: "🧎", items: [
          { name: "腕立て",   detail_key: "pushup" },
          { name: "スクワット", detail_key: "squat" },
          { name: "腹筋",     detail_key: "situp" },
          { name: "背筋",     detail_key: "back" }
        ] }
    ]

    exercise_items = ExerciseItem.where(name: categories.flat_map { |c| c[:items].map { |it| it[:name] } })
    item_by_name = exercise_items.index_by(&:name)

    categories.map do |category|
      mapped_items = category[:items].filter_map do |item|
        record = item_by_name[item[:name]]
        next unless record

        {
          name: item[:name],
          detail_key: item[:detail_key],
          points: record.base_points,
          exercise_item_id: record.id
        }
      end

      category.merge(items: mapped_items)
    end
  end
end
