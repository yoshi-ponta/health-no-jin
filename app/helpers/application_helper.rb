module ApplicationHelper
  def inline_svg(name, classes: "w-6 h-6", aria_hidden: true)
    path = Rails.root.join("app/assets/images/icons/#{name}.svg")
    return "(missing #{name}.svg)" unless File.exist?(path)

    svg = File.read(path)

    svg.sub!(/<svg\b/, "<svg class=\"#{classes}\"")
    svg.sub!(/<svg\b/, "<svg aria-hidden=\"true\" focusable=\"false\"") if aria_hidden
    svg.html_safe
  end

  def footer_nav_link_to(path, label, icon:, active_when: nil, **opts)
    active = active_when.nil? ? current_page?(path) : !!active_when
    base   = "flex flex-col items-center justify-center gap-1 py-3 text-xs select-none"
    color  = active ? "text-blue-600" : "text-gray-500 hover:text-gray-700"
    link_to path, { class: "#{base} #{color}" }.merge(opts) do
      concat inline_svg(icon, classes: "w-6 h-6")
      concat content_tag(:span, label, class: "leading-none")
    end
  end

  def default_meta_tags
    image_for_ogp = image_url("ogp/default_ogp.png")
    base = {
      site: "Health-no-Jin",
      title: "ヘルスノ陣",
      reverse: true,
      charset: "utf-8",
      description: "ヘルスノ陣は、家族や友人とグループを作り、毎日の運動をポイント化！集めたポイントで「城」を育てながら、楽しく健康寿命を延ばす為のサービスです。",
      canonical: request.original_url,
      separator: "｜",
      og: {
        site_name: "ヘルスノ陣",
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_for_ogp,
        locale: "ja_JP"
      },
      twitter: {
        card: "summary",
        image: image_for_ogp
      }
    }
  end
end
