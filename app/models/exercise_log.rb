class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_item

  validates :performed_at, presence: true
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
