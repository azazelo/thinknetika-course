class String
  def humanize
    tr('_', ' ').capitalize
  end

  # 0 Turn off all attributes
  # 1 Set bright mode
  # 4 Set underline mode
  # 5 Set blink mode
  # 7 Exchange foreground and background colors
  # 8 Hide text (foreground color would be the same as background)
  MODES = {
    all_off:   0,
    bright:    1,
    underline: 4,
    blink:     5,
    negative:  7,
    hide:      8
  }.freeze

  MODES.each do |key, mode|
    define_method key do
      "\e[#{mode}m#{self}\e[m"
    end
  end

  # Font colors
  # 30 Black text
  # 31 Red text
  # 32 Green text
  # 33 Yellow text
  # 34 Blue text
  # 35 Magenta text
  # 36 Cyan text
  # 37 White text
  # 39 Default text color
  # Background colors
  #
  # 40 Black background
  # 41 Red background
  # 42 Green background
  # 43 Yellow background
  # 44 Blue background
  # 45 Magenta background
  # 46 Cyan background
  # 47 White background
  # 49 Default background color
  COLOR_CODES = {
    black:           30,
    red:             31,
    green:           32,
    yellow:          33,
    blue:            34,
    magenta:         35,
    cyan:            36,
    white:           37,
    default:         39,
    green_bg:        42,
    yellow_bg:       43,
    blue_bg:         44,
    magenta_bg:      45,
    cyan_bg:         46,
    white_bg:        47,
    default_bg:      49,
    light_yellow:    228,
    light_yellow_bg: 228
  }.freeze
  FG = 38
  BG = 48

  COLOR_CODES.each do |key, color_code|
    define_method key do
      "\e[#{fg_bg(key)};#{color_code}m#{self}\e[m"
    end
  end

  def fg_bg(key)
    key.to_s.include?('_bg') ? BG : FG
  end
end
