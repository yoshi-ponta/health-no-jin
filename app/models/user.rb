class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id", dependent: :nullify
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
end
