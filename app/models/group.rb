class Group < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: false
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true, length: { maximum: 50 }

  before_create :ensure_invite_token
  def ensure_invite_token
    self.invite_token ||= SecureRandom.urlsafe_base64(24)
  end

  def total_points(range: nil)
    logs = ExerciseLog
      .joins(user: :group_memberships)
      .where(group_memberships: { group_id: id })
      .where("exercise_logs.performed_at >= group_memberships.joined_at")
      .where("group_memberships.left_at IS NULL OR exercise_logs.performed_at < group_memberships.left_at")

    logs = logs.where(performed_at: range) if range
    logs.sum(:points)
  end
end
