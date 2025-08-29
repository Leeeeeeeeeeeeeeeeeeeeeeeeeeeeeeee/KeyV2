// Convenience modules for Ultimate Hacking Keyboard 80 keycaps
// Usage: include this file in keys.scad and reference modules like
// R1U1() legend("text") key();
// Decimal unit sizes use underscores, e.g. R2U1_25 for a 1.25u key.

include <./includes.scad>;

// Defaults for UHK80 keys
$font_size = 4; // Font size for legends
$outset_legends = true;
$support_type = "disable";
$stem_support_type = "disable";
$stabilizer_type = "disable";

// Default vertical depth multiplier for UHK80 keys (50% taller than standard)
$uhk80_depth_scale = 1.5;

// Default top dish depth controlling curvature (higher values curve more)
$uhk80_dish_depth = 0.75;

// Additional forward tilt in degrees; negative tilts top downward more
$uhk80_tilt_adjust = -2;

// Internal helper for applying row profile, unit width, and depth scaling
module _uhk80_key(row, u) {
  let($dish_depth_override = $uhk80_dish_depth)
    dcs_row(row) u(u) {
      let(
        extra_depth = $total_depth * ($uhk80_depth_scale - 1),
        $stem_inset = $stem_inset + extra_depth,
        $total_depth = $total_depth * $uhk80_depth_scale,
        $top_tilt = $top_tilt + $uhk80_tilt_adjust
      ) children();
    }
}

// Row 1
module R1U1() { _uhk80_key(1,1) children(); }
module R1U1_25() { _uhk80_key(1,1.25) children(); }
module R1U1_5() { _uhk80_key(1,1.5) children(); }
module R1U1_75() { _uhk80_key(1,1.75) children(); }
module R1U2() { _uhk80_key(1,2) children(); }
module R1U2_25() { _uhk80_key(1,2.25) children(); }
module R1U2_75() { _uhk80_key(1,2.75) children(); }
module R1U6_25() { _uhk80_key(1,6.25) children(); }

// Row 2
module R2U1() { _uhk80_key(2,1) children(); }
module R2U1_25() { _uhk80_key(2,1.25) children(); }
module R2U1_5() { _uhk80_key(2,1.5) children(); }
module R2U1_75() { _uhk80_key(2,1.75) children(); }
module R2U2() { _uhk80_key(2,2) children(); }
module R2U2_25() { _uhk80_key(2,2.25) children(); }
module R2U2_75() { _uhk80_key(2,2.75) children(); }
module R2U6_25() { _uhk80_key(2,6.25) children(); }

// Row 3
module R3U1() { _uhk80_key(3,1) children(); }
module R3U1_25() { _uhk80_key(3,1.25) children(); }
module R3U1_5() { _uhk80_key(3,1.5) children(); }
module R3U1_75() { _uhk80_key(3,1.75) children(); }
module R3U2() { _uhk80_key(3,2) children(); }
module R3U2_25() { _uhk80_key(3,2.25) children(); }
module R3U2_75() { _uhk80_key(3,2.75) children(); }
module R3U6_25() { _uhk80_key(3,6.25) children(); }

// Row 4
module R4U1() { _uhk80_key(4,1) children(); }
module R4U1_25() { _uhk80_key(4,1.25) children(); }
module R4U1_5() { _uhk80_key(4,1.5) children(); }
module R4U1_75() { _uhk80_key(4,1.75) children(); }
module R4U2() { _uhk80_key(4,2) children(); }
module R4U2_25() { _uhk80_key(4,2.25) children(); }
module R4U2_75() { _uhk80_key(4,2.75) children(); }
module R4U6_25() { _uhk80_key(4,6.25) children(); }

// Row 4X / 5 (bottom row)
module R4XU1() { _uhk80_key(5,1) children(); }
module R4XU1_25() { _uhk80_key(5,1.25) children(); }
module R4XU1_5() { _uhk80_key(5,1.5) children(); }
module R4XU1_75() { _uhk80_key(5,1.75) children(); }
module R4XU2() { _uhk80_key(5,2) children(); }
module R4XU2_25() { _uhk80_key(5,2.25) children(); }
module R4XU2_75() { _uhk80_key(5,2.75) children(); }
module R4XU6_25() { _uhk80_key(5,6.25) children(); }

// Optional aliases for R5 naming
module R5U1() { _uhk80_key(5,1) children(); }
module R5U1_25() { _uhk80_key(5,1.25) children(); }
module R5U1_5() { _uhk80_key(5,1.5) children(); }
module R5U1_75() { _uhk80_key(5,1.75) children(); }
module R5U2() { _uhk80_key(5,2) children(); }
module R5U2_25() { _uhk80_key(5,2.25) children(); }
module R5U2_75() { _uhk80_key(5,2.75) children(); }
module R5U6_25() { _uhk80_key(5,6.25) children(); }

// Layout grid for UHK80 halves
// Key tuple format (units in keyboard units, "u"):
// [ R, U, legend, x, y, font_size ]
// - R: row/profile number (1..5; 5 == bottom/R4X)
// - U: key width (e.g., 1, 1.25, 2)
// - legend: text rendered on the key (UTF‑8 supported)
// - x, y: position on unit grid (x right, y down). Decimals allow fine nudges.
// - font_size: legend size override for that key
uhk80_left_layout = [
  [1, 1, "Esc", 0, 0, 4],
  [1, 1, "F1", 1, 0, 3],
  [1, 1, "F2", 2, 0, 3],
  [1, 1, "F3", 3, 0, 3],
  [1, 1, "F4", 4, 0, 3],
  [1, 1, "F5", 5, 0, 3],
  [1, 1, "F6", 6, 0, 3],

  [2, 1, "1", 0, -1, 4],
  [2, 1, "2", 1, -1, 4],
  [2, 1, "3", 2, -1, 4],
  [2, 1, "4", 3, -1, 4],
  [2, 1, "5", 4, -1, 4],
  [2, 1, "6", 5, -1, 4],

  [3, 1.5, "Tab", 0, -2, 4],
  [3, 1, "Q", 1.5, -2, 4],
  [3, 1, "W", 2.5, -2, 4],
  [3, 1, "E", 3.5, -2, 4],
  [3, 1, "R", 4.5, -2, 4],
  [3, 1, "T", 5.5, -2, 4],

  [4, 1.75, "Caps", 0, -3, 4],
  [4, 1, "A", 1.75, -3, 4],
  [4, 1, "S", 2.75, -3, 4],
  [4, 1, "D", 3.75, -3, 4],
  [4, 1, "F", 4.75, -3, 4],
  [4, 1, "G", 5.75, -3, 4],

  [5, 1.25, "Shift", 0, -4, 4],
  [5, 1, "Z", 1.25, -4, 4],
  [5, 1, "X", 2.25, -4, 4],
  [5, 1, "C", 3.25, -4, 4],
  [5, 1, "V", 4.25, -4, 4],
  [5, 1, "B", 5.25, -4, 4],

  [5, 1.25, "Ctrl", 0, -5, 4],
  [5, 1.25, "Super", 1.25, -5, 4],
  [5, 1.25, "Alt", 2.5, -5, 4],
  [5, 2.25, "Space", 3.75, -5, 4]
];

uhk80_right_layout = [
  [1, 1, "F7", 7, 0, 3],
  [1, 1, "F8", 8, 0, 3],
  [1, 1, "F9", 9, 0, 3],
  [1, 1, "F10", 10, 0, 3],
  [1, 1, "F11", 11, 0, 3],
  [1, 1, "F12", 12, 0, 3],
  [1, 2, "Print", 13.5, 0, 3],
  [1, 1, "ScrLk", 15, 0, 3],
  [1, 1, "Pause", 16, 0, 3],

  [2, 1, "7", 7, -1, 4],
  [2, 1, "8", 8, -1, 4],
  [2, 1, "9", 9, -1, 4],
  [2, 1, "0", 10, -1, 4],
  [2, 1, "-", 11, -1, 4],
  [2, 1, "=", 12, -1, 4],
  [1, 2, "Backspace", 13.5, -1, 4],
  [1, 1, "Ins", 15, -1, 4],
  [1, 1, "Del", 16, -1, 4],

  [3, 1, "Y", 7, -2, 4],
  [3, 1, "U", 8, -2, 4],
  [3, 1, "I", 9, -2, 4],
  [3, 1, "O", 10, -2, 4],
  [3, 1, "P", 11, -2, 4],
  [3, 1, "[", 12, -2, 4],
  [3, 1, "]", 13, -2, 4],
  [3, 1, "\\", 14, -2, 4],
  [2, 1, "Home", 15, -2, 4],
  [2, 1, "PgUp", 16, -2, 4],

  [4, 1, "H", 5.75, -3, 4],
  [4, 1, "J", 6.75, -3, 4],
  [4, 1, "K", 7.75, -3, 4],
  [4, 1, "L", 8.75, -3, 4],
  [4, 1, ";", 9.75, -3, 4],
  [4, 1, "'", 10.75, -3, 4],
  [4, 2.25, "Enter", 12.375, -3, 4],
  // Arrow cluster (same row as right Shift)
  [5, 1, "\u2190", 14.75, -4, 4],
  [5, 1, "\u2193", 15.75, -4, 4],
  [5, 1, "\u2192", 16.75, -4, 4],

  [5, 1, "N", 7, -4, 4],
  [5, 1, "M", 8, -4, 4],
  [5, 1, ",", 9, -4, 4],
  [5, 1, ".", 10, -4, 4],
  [5, 1, "/", 11, -4, 4],
  [5, 2.75, "Shift", 12, -4, 4],

  [5, 2.25, "Space", 7, -5, 4],
  [5, 1.25, "Alt", 9.25, -5, 4],
  [5, 1.25, "Fn", 10.5, -5, 4],
  [5, 1.25, "Ctrl", 11.75, -5, 4]
];

// Render selected half of the UHK80 layout
// side can be "left", "right", or "both"
module uhk80_half(side="both") {
  if (side == "left" || side == "both")
    _uhk80_render_half(uhk80_left_layout);
  if (side == "right" || side == "both")
    _uhk80_render_half(uhk80_right_layout);
}

// Internal: render a list of keys using _uhk80_key
module _uhk80_render_half(keys) {
  for (k = keys)
    translate_u(k[3], k[4])
      _uhk80_key(k[0], k[1]) legend(k[2], size=k[5]) key();
}

uhk80_half("right");
