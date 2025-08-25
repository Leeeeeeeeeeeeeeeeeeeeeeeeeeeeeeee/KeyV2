include <./includes.scad>;


// -----------------------------------------------------------------------------
//  Layout data for the right half of the Ultimate Hacking Keyboard 80 (UHK80)
// -----------------------------------------------------------------------------
// Each element in `uhk80_right_rows` represents a row starting from the top.
// Each row is an array of keys.  A key is represented by:
//   [row_profile, width_in_u, legend_text, optional_font_size]
// `row_profile` follows standard keyboard row numbering (1 = top row).
// A `row_profile` of 0 marks an empty slot / spacer that advances the x offset
// without rendering an actual key.
uhk80_right_rows = [
  // Row 1: function keys, print-screen cluster
  [
    [1, 1, "F7", 3], [1, 1, "F8", 3], [1, 1, "F9", 3],
    [1, 1, "F10", 3], [1, 1, "F11", 3], [1, 1, "F12", 3],
    [0, 1.5], // spacer between F-keys and print-screen cluster
    [1, 1.5, "PrtSc", 3], [1, 1, "Scroll", 3], [1, 1, "Pause", 3]
  ],

  // Row 2: number row
  [
    [2, 1, "7"], [2, 1, "8"], [2, 1, "9"],
    [2, 1, "0"], [2, 1, "-"], [2, 1, "="],
    [1, 1.5, "Backspace"], [0, 0.5],
    [1, 1, "Insert"], [1, 1, "Home"], [1, 1, "PgUp"]
  ],

  // Row 3: QWERTY row
  [
    [3, 1, "Y"], [3, 1, "U"], [3, 1, "I"],
    [3, 1, "O"], [3, 1, "P"], [3, 1, "["],
    [3, 1, "]"], [3, 1, "\\"],
    [2, 1, "Delete"], [2, 1, "End"], [2, 1, "PgDn"]
  ],

  // Row 4: home row
  [
    [4, 1, "H"], [4, 1, "J"], [4, 1, "K"],
    [4, 1, "L"], [4, 1, ";"], [4, 1, "'"],
    [4, 2.25, "Enter"], [0, 0.75],
    [4, 1, "\u2190"], [4, 1, "\u2193"], [4, 1, "\u2192"]
  ],

  // Row 5: bottom letter row
  [
    [5, 1, "N"], [5, 1, "M"], [5, 1, ","],
    [5, 1, "."], [5, 1, "/"], [5, 2.75, "Shift"]
  ],

  // Row 6: space bar row
  [
    [5, 2.25, "Space"], [5, 1.25, "Alt"],
    [5, 1.25, "Fn"], [5, 1.25, "Ctrl"]
  ]
];


// -----------------------------------------------------------------------------
//  Render a single row from the right half
// -----------------------------------------------------------------------------
// row : 1-indexed row number counting from the top (1 = F7 row)
// Example usage:
//   use <uhk80.scad>
//   uhk80_right_row(1);  // renders the top row on the right half
module uhk80_right_row(row = 1) {

  // Grab the key data for the requested row
  row_data = uhk80_right_rows[row - 1];

  // Track how far we've moved along the X axis.  Starts at 0 for the first key.
  x_offset = 0;

  // Loop over every key definition in the row
  for (key = row_data) {

    // Unpack the key definition for readability
    row_profile = key[0];      // Which sculpted row this key uses (1..5). 0 = spacer.
    width       = key[1];      // Width in "U" units (1u, 1.5u, etc)

    // Only render real keys (skip spacers with row_profile == 0)
    if (row_profile > 0) {

      // Extract legend information, falling back to sensible defaults
      legend_text = (len(key) > 2) ? key[2] : "";
      font_size   = (len(key) > 3) ? key[3] : 4;

      // Position the key:
      //   * x_offset is how far we've moved to the right so far
      //   * -(row - 1) moves down one unit per row (row1 -> 0, row2 -> -1, ...)
      translate_u(x_offset, -(row - 1)) {

        // Apply the appropriate row profile and key width before drawing
        dcs_row(row_profile) u(width) {

          // Apply the legend then render the key geometry
          legend(legend_text, size = font_size) {
            key();
          }
        }
      }
    }

    // Move the x_offset forward by this key's width so the next key
    // is placed immediately to the right
    x_offset = x_offset + width;
  }
}

// Uncomment the line below to preview the first row when this file is opened
// uhk80_right_row(1);
