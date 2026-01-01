# frozen_string_literal: true

module ReportsHelper
  def styler(number)
    "line-height: 1.2; font-size: #{sizer(number)}px; opacity: #{opacitizer(number)}; #{rotation_style}; color: #{color_hex(number)}; font-weight: #{weight(number)};"
  end

  def sizer(number)
    # Scale from 16px to 72px based on frequency
    base = number + 10
    return 72 if base > 72
    return 16 if base <= 16

    base
  end

  def opacitizer(number)
    # More frequent words should be MORE visible, so higher opacity
    return 1.0 if number >= 20
    return 0.9 if number >= 15
    return 0.8 if number >= 10
    return 0.7 if number >= 5

    0.6
  end

  def color_hex(number)
    # Use frequency tiers for color coding
    case number
    when 30.. then %w[#9333ea #db2777 #c026d3].sample # purple, pink, fuchsia
    when 20...30 then %w[#2563eb #4f46e5 #7c3aed].sample # blue, indigo, violet
    when 10...20 then %w[#059669 #0d9488 #0891b2].sample # green, teal, cyan
    when 5...10 then %w[#f59e0b #f59e0b #ca8a04].sample # orange, amber, yellow
    else %w[#4b5563 #64748b].sample # gray, slate
    end
  end

  def rotation_style
    # Random subtle rotation for variety
    rotations = [
      "",
      "",
      "",
      "transform: rotate(2deg)",
      "transform: rotate(-2deg)",
      "transform: rotate(3deg)",
      "transform: rotate(-3deg)",
      "transform: rotate(1deg)",
      "transform: rotate(-1deg)"
    ]
    rotations.sample
  end

  def weight(number)
    (number >= 15) ? "700" : "500"
  end

  def word_classes
    "word-cloud-item"
  end
end
