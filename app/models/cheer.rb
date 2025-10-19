class Cheer < ApplicationRecord
  belongs_to :group
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user,   class_name: "User"

  before_validation :set_jst_date, if: -> { cheered_on.blank? }
  validates :group, :from_user, :to_user, :cheered_on, presence: true
  validates :to_user_id, uniqueness: { scope: [ :group_id, :from_user_id, :cheered_on ] }

  after_create_commit :notify_recipient

  def self.cheered_today?(group:, from_user:, to_user:)
    jst_today = Time.use_zone("Asia/Tokyo") { Time.zone.today }
    exists?(group: group, from_user: from_user, to_user: to_user, cheered_on: jst_today)
  end

  private

  def set_jst_date
    self.cheered_on = Time.use_zone("Asia/Tokyo") { Time.zone.today }
  end

  def notify_recipient
    Notification.create!(user: to_user, actor: from_user, notifiable: self)
  end
end
