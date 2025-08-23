// Convenience modules for Ultimate Hacking Keyboard 80 keycaps
// Usage: include this file in keys.scad and reference modules like
// R1U1() legend("text") key();
// Decimal unit sizes use underscores, e.g. R2U1_25 for a 1.25u key.

include <./includes.scad>;

// Internal helper for applying row profile and unit width
module _uhk80_key(row, u) {
  dcs_row(row) u(u) children();
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

