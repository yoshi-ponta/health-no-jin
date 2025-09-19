class ExerciseLogsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @exercise_log = ExerciseLog.new(performed_at: Time.zone.now)
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)
    if @exercise_log.save
      redirect_to new_exercise_log_path, notice: "記録しました"
    else
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
end
