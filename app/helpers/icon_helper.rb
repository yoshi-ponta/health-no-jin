module IconHelper
  def user_avatar_tag(user, size: 56, class_name: "")
    alt = "#{user&.name.presence || 'ユーザー'}のアイコン"
    if user&.avatar&.attached? && user.avatar.blob&.persisted?
      image_tag(
        user.avatar.variant(resize_to_fill: [ 56, 56 ]),
        alt: alt,
        loading: "lazy",
        class: "h-14 w-14 rounded-full object-cover ring-1 ring-gray-200 #{class_name}"
      )
    else
      initials = (user&.name.presence || "無").first(1).upcase
      content_tag(
        :div, initials,
        class: "h-14 w-14 rounded-full bg-gray-300 text-gray-700 flex items-center justify-center text-xs font-semibold #{class_name}",
        title: alt
      )
    end
  end
end
