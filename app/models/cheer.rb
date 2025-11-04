class Cheer < ApplicationRecord
  belongs_to :group
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user,   class_name: "User"

  before_validation :set_cheered_on, on: :create

  validates :group, :from_user, :to_user, :cheered_on, presence: true
  validates :to_user_id, uniqueness: { scope: %i[group_id from_user_id cheered_on] }

  after_create_commit :notify_recipient

  def self.cheered_today?(group:, from_user:, to_user:)
    exists?(group: group, from_user: from_user, to_user: to_user, cheered_on: Time.zone.today)
  end

  private

  def set_cheered_on
    self.cheered_on ||= Time.zone.today
  end

  def notify_recipient
    Notification.create!(user: to_user, actor: from_user, notifiable: self)
  end
end
