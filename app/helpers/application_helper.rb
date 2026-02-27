module ApplicationHelper
  COLOR_MAP = {
    "gold"    => { bg: "#f59e0b", light: "rgba(245,158,11,0.1)", lighter: "rgba(245,158,11,0.05)", text: "#fbbf24", from: "#f59e0b", to: "#fbbf24" },
    "emerald" => { bg: "#10b981", light: "rgba(16,185,129,0.1)", lighter: "rgba(16,185,129,0.05)", text: "#34d399", from: "#10b981", to: "#34d399" },
    "blue"    => { bg: "#3b82f6", light: "rgba(59,130,246,0.1)", lighter: "rgba(59,130,246,0.05)", text: "#60a5fa", from: "#3b82f6", to: "#60a5fa" },
    "purple"  => { bg: "#a855f7", light: "rgba(168,85,247,0.1)", lighter: "rgba(168,85,247,0.05)", text: "#c084fc", from: "#a855f7", to: "#c084fc" },
    "amber"   => { bg: "#f59e0b", light: "rgba(245,158,11,0.1)", lighter: "rgba(245,158,11,0.05)", text: "#fbbf24", from: "#f59e0b", to: "#fbbf24" },
    "red"     => { bg: "#ef4444", light: "rgba(239,68,68,0.1)",  lighter: "rgba(239,68,68,0.05)",  text: "#f87171", from: "#ef4444", to: "#f87171" },
    "gray"    => { bg: "#6b7280", light: "rgba(107,114,128,0.1)", lighter: "rgba(107,114,128,0.05)", text: "#9ca3af", from: "#6b7280", to: "#9ca3af" },
  }.freeze

  def theme_color(name, variant = :bg)
    COLOR_MAP.dig(name.to_s, variant) || COLOR_MAP.dig("gold", variant)
  end
end
