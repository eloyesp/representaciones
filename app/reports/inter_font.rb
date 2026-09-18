module InterFont
  FONT_PATH = Rails.root.join("app/assets/fonts")

  FAMILY = {
    "Inter" => {
      normal:      FONT_PATH.join("Inter-Regular.ttf").to_s,
      bold:        FONT_PATH.join("Inter-Bold.ttf").to_s,
      italic:      FONT_PATH.join("Inter-Italic.ttf").to_s,
      bold_italic: FONT_PATH.join("Inter-Bold.ttf").to_s
    }
  }.freeze

  def initialize(options = {}, &block)
    super
    font_families.update(FAMILY)
    font "Inter"
  end
end