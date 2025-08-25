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

// Layout data for UHK80 halves
// Row numbers start at the top: row 1 is the F1/F7 row for left/right halves

// Left half rows: [ [row, width, legend, (optional) font size], ... ]
uhk80_left_rows = [
  // Row 1
  [
    [1, 1, "Esc"],
    [1, 1, "F1", 3],
    [1, 1, "F2", 3],
    [1, 1, "F3", 3],
    [1, 1, "F4", 3],
    [1, 1, "F5", 3],
    [1, 1, "F6", 3]
  ],
  // Row 2
  [
    [2, 1, "1"], [2, 1, "2"], [2, 1, "3"],
    [2, 1, "4"], [2, 1, "5"], [2, 1, "6"]
  ],
  // Row 3
  [
    [3, 1.5, "Tab"], [3, 1, "Q"], [3, 1, "W"],
    [3, 1, "E"], [3, 1, "R"], [3, 1, "T"]
  ],
  // Row 4
  [
    [4, 1.75, "Caps"], [4, 1, "A"], [4, 1, "S"],
    [4, 1, "D"], [4, 1, "F"], [4, 1, "G"]
  ],
  // Row 5
  [
    [5, 1.25, "Shift"], [5, 1, "Z"], [5, 1, "X"],
    [5, 1, "C"], [5, 1, "V"], [5, 1, "B"]
  ],
  // Row 6 (bottom)
  [
    [5, 1.25, "Ctrl"], [5, 1.25, "Super"],
    [5, 1.25, "Alt"], [5, 2.25, "Space"]
  ]
];

// Right half rows
uhk80_right_rows = [
  // Row 1
  [
    [1, 1, "F7", 3], [1, 1, "F8", 3], [1, 1, "F9", 3],
    [1, 1, "F10", 3], [1, 1, "F11", 3], [1, 1, "F12", 3],
    [0, 1.5],
    [1, 1.5, "PrtSc", 3], [1, 1, "Scroll", 3], [1, 1, "Pause", 3]
  ],
  // Row 2
  [
    [2, 1, "7"], [2, 1, "8"], [2, 1, "9"],
    [2, 1, "0"], [2, 1, "-"], [2, 1, "="],
    [1, 1.5, "Backspace"], [0, 0.5],
    [1, 1, "Insert"], [1, 1, "Home"], [1, 1, "PgUp"]
  ],
  // Row 3
  [
    [3, 1, "Y"], [3, 1, "U"], [3, 1, "I"],
    [3, 1, "O"], [3, 1, "P"], [3, 1, "["],
    [3, 1, "]"], [3, 1, "\\"],
    [2, 1, "Delete"], [2, 1, "End"], [2, 1, "PgDn"]
  ],
  // Row 4
  [
    [4, 1, "H"], [4, 1, "J"], [4, 1, "K"],
    [4, 1, "L"], [4, 1, ";"], [4, 1, "'"],
    [4, 2.25, "Enter"], [0, 0.75],
    [4, 1, "\u2190"], [4, 1, "\u2193"], [4, 1, "\u2192"]
  ],
  // Row 5
  [
    [5, 1, "N"], [5, 1, "M"], [5, 1, ","],
    [5, 1, "."], [5, 1, "/"], [5, 2.75, "Shift"]
  ],
  // Row 6 (bottom)
  [
    [5, 2.25, "Space"], [5, 1.25, "Alt"],
    [5, 1.25, "Fn"], [5, 1.25, "Ctrl"]
  ]
];

// Render selected half of the UHK80 layout
// side can be "left", "right", or "both"
// rows can be an integer or vector of integers to render only specific rows
module uhk80_half(side="both", rows=undef, gap=0.5) {
  if (side == "left" || side == "both")
    _uhk80_render_half(uhk80_left_rows, rows);
  if (side == "right" || side == "both")
    translate_u(side == "both" ? gap : 0) {
      _uhk80_render_half(
        uhk80_right_rows,
        rows,
        end_column=17,
        align_right=true
      );

      // Arrow up key sits above the arrow cluster; render when row 3 is included
      if (rows == undef || rows == 3 || (is_list(rows) && len([for (r = rows) if (r == 3) r]) > 0))
        translate_u(16, -2)
          _uhk80_key(3, 1) legend("\u2191") key();
    }
}

// Internal: render rows of keys using _uhk80_key
module _uhk80_render_half(rows_data, rows=undef, end_column=undef, align_right=false, starts=0) {
  for (i = [0 : len(rows_data) - 1]) {
    row_number = i + 1;
    if (rows == undef || row_number == rows || (is_list(rows) && len([for (r = rows) if (r == row_number) r]) > 0)) {
      row = rows_data[i];
      align = is_list(align_right)
          ? (i < len(align_right) ? align_right[i] : false)
          : align_right;
      start = is_list(starts)
          ? (i < len(starts) ? starts[i] : 0)
          : starts;
      total_width = sum([for (k = row) k[1]]);
      last_width = row[len(row) - 1][1];
      x = align && end_column != undef
          ? end_column - (total_width - last_width)
          : start;
      for (key = row) {
        width = key[1];
        if (len(key) > 2)
          translate_u(x, -i)
            _uhk80_key(key[0], width) legend(key[2], size = len(key) > 3 ? key[3] : 4) key();
        x = x + width;
      }
    }
  }
}

// Example: render both halves
uhk80_half("both");
