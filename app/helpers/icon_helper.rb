module IconHelper
  def user_avatar_tag(user, size: 56, class_name: "")
    alt = "#{user&.name.presence || 'ユーザー'}のアイコン"

    if user&.avatar&.attached? && user.avatar.blob&.persisted?
      avatar = safe_avatar_variant(user.avatar, size)
      image_tag(
        avatar,
        alt: alt,
        loading: "lazy",
        class: "rounded-full object-cover ring-1 ring-gray-200 #{class_name}",
        style: avatar_dimension_style(size)
      )
    else
      initials = (user&.name.presence || "無").first(1).upcase
      content_tag(
        :div, initials,
        class: "rounded-full bg-gray-300 text-gray-700 flex items-center justify-center text-xs font-semibold #{class_name}",
        title: alt,
        style: avatar_dimension_style(size)
      )
    end
  end

  private

  def safe_avatar_variant(avatar, size)
    avatar.variant(resize_to_fill: [ size, size ])
  rescue StandardError => e
    Rails.logger.error("Avatar variant processing failed: #{e.class} - #{e.message}") if defined?(Rails)
    avatar
  end

  def avatar_dimension_style(size)
    "width: #{size}px; height: #{size}px;"
  end
end
