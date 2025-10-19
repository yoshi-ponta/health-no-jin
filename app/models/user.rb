class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id", dependent: :nullify
  has_many :group_memberships, dependent: :destroy
  has_many :exercise_logs, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :notifications, dependent: :destroy, inverse_of: :user
  has_many :notifications_as_actor, class_name: "Notification",foreign_key: :actor_id, dependent: :nullify, inverse_of: :actor
end
