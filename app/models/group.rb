class Group < ApplicationRecord
  belongs_to :owner, class_name: "User", optional: false
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true, length: { maximum: 50 }

  before_create :ensure_invite_token
  def ensure_invite_token
    self.invite_token ||= SecureRandom.urlsafe_base64(24)
  end
end
