module ApplicationHelper
  # /app/assets/images/icons/<name>.svg をインライン描画
  def inline_svg(name, classes: "w-6 h-6", aria_hidden: true)
    path = Rails.root.join("app/assets/images/icons/#{name}.svg")
    return "(missing #{name}.svg)" unless File.exist?(path)

    svg = File.read(path)
    # class 付与（既存があっても上書きでOKにする簡易版）
    svg.sub!(/<svg\b/, "<svg class=\"#{classes}\"")
    svg.sub!(/<svg\b/, "<svg aria-hidden=\"true\" focusable=\"false\"") if aria_hidden
    svg.html_safe
  end

  # フッターナビのリンク（アイコン＋ラベル／現在地で色強調）
  def footer_nav_link_to(path, label, icon:, active_when: nil, **opts)
    active = active_when.nil? ? current_page?(path) : !!active_when
    base   = "flex flex-col items-center justify-center gap-1 py-3 text-xs select-none"
    color  = active ? "text-blue-600" : "text-gray-500 hover:text-gray-700"
    link_to path, { class: "#{base} #{color}" }.merge(opts) do
      concat inline_svg(icon, classes: "w-6 h-6")
      concat content_tag(:span, label, class: "leading-none")
    end
  end

