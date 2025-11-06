class ExerciseItem < ApplicationRecord
  has_many :exercise_logs, dependent: :restrict_with_error

  before_validation :normalize_keys

  validates :category, :icon, :name, :detail_key, presence: true
  validates :detail_key, uniqueness: { scope: :category }
  validates :name,       uniqueness: { scope: :category }
  validates :base_points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered,      -> { order(:category, :name) }
  scope :by_category,  ->(cat) { where(category: cat) }
  scope :search,       ->(q) {
    q = q.to_s.strip
    return all if q.blank?
    where("name ILIKE ? OR detail_key ILIKE ?", "%#{q}%", "%#{q}%")
  }

  private

  def normalize_keys
    self.detail_key = detail_key.to_s.strip.downcase.tr("　", " ").gsub(/\s+/, "_")
    self.category   = category.to_s.strip.downcase
    self.name       = name.to_s.strip
    self.icon       = icon.to_s.strip
  end
end
