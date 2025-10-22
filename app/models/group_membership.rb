class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  scope :active, -> { where(left_at: nil) }
end
