class ExerciseLog < ApplicationRecord
  belongs_to :user
  belongs_to :exercise_item

  validates :performed_at, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
