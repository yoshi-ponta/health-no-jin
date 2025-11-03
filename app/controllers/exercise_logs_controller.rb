class ExerciseLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_group!

  def index; end

  def new
    @exercise_log = ExerciseLog.new(performed_at: Time.current, amount: 1)
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

  def show; end

  private

  def exercise_log_params
    params.require(:exercise_log).permit(:exercise_item_id, :amount, :performed_at, :memo, :group_id)
  end

  # 運動カテゴリーの並び順
  CATEGORY_ORDER = %w[running running2 pushup pushup2 stretch stretch2 daily recovery sports].freeze

  def exercise_categories
    records = ExerciseItem.ordered.to_a
    grouped = records.group_by(&:category)

    grouped
      .sort_by { |(cat, _)| CATEGORY_ORDER.index(cat) || 999 }
      .map do |cat, items|
        {
          key:  cat,
          name: I18n.t("categories.#{cat}", default: cat),
          icon: I18n.t("category_icons.#{cat}", default: (items.first&.icon.to_s)),
          items: items.map { |r|
            { name: r.name, detail_key: r.detail_key, points: r.base_points, exercise_item_id: r.id }
          }
        }
      end
  end
end
