class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_item
  belongs_to :group, optional: true

  before_validation :set_defaults
  before_validation :assign_points

  validates :performed_at, presence: true
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  private

  def set_defaults
    self.amount = (amount.presence || 1)
    self.performed_at ||= Time.zone.now
  end

  def assign_points
    return unless exercise_item

    self.points = exercise_item.base_points.to_i * amount.to_i
  end
end
