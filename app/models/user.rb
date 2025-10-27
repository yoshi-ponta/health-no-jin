class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar
  validate :avatar_validation

  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id", dependent: :nullify
  has_many :group_memberships, dependent: :destroy
  has_many :exercise_logs, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :notifications, dependent: :destroy, inverse_of: :user
  has_many :notifications_as_actor, class_name: "Notification", foreign_key: :actor_id, dependent: :nullify, inverse_of: :actor

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email    ||= auth.info.email
    user.password ||= Devise.friendly_token[0, 20]
    user
  end

  private
  def avatar_validation
    return unless avatar.attached?
    errors.add(:avatar, "は画像ファイルを選んでください") unless avatar.content_type&.start_with?("image/")
    errors.add(:avatar, "は5MB以下にしてください") if avatar.byte_size > 5.megabytes
  end
end
