module ImageUploadRules
  extend ActiveSupport::Concern

  included do
    class_attribute :image_rules, default: { allowed: %w[image/png image/jpeg image/webp], max_bytes: 10.megabytes  }

    validate :_img_content_type, :_img_file_size
  end

  private
  def attached_image
    respond_to?(:image) ? image : nil
  end

  def _img_content_type
    img = attached_image
    return unless img&.attached?
    unless image_rules[:allowed].include?(img.blob.content_type)
      errors.add(:base, "画像は PNG / JPEG / WebP のみアップできます")
    end
  end

  def _img_file_size
    img = attached_image
    return unless img&.attached?
    if img.blob.byte_size > image_rules[:max_bytes]
      errors.add(:base, "画像サイズは #{(image_rules[:max_bytes] / 1.megabyte)}MB 以下にしてください")
    end
  end
end
