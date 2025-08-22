
// Generate a single key from the UHK80 layout using a code like "R3U1".
// The code encodes the profile row (R1..R5) and the key width in units.
// Example usage:
//   uhk80("R3U1.25") legend("A") key();
// This will emit a 1.25u key in row 3 of the selected profile.

function _uhk80_row(code) =
    search("R5", code) != [] ? 5 :
    search("R4", code) != [] ? 4 :
    search("R3", code) != [] ? 3 :
    search("R2", code) != [] ? 2 :
    search("R1", code) != [] ? 1 :
    0;

function _uhk80_width(code) =
    search("6.25", code) != [] ? 6.25 :
    search("2.75", code) != [] ? 2.75 :
    search("2.5", code)  != [] ? 2.5  :
    search("2.25", code) != [] ? 2.25 :
    search("1.75", code) != [] ? 1.75 :
    search("1.5", code)  != [] ? 1.5  :
    search("1.25", code) != [] ? 1.25 :
    search("2", code)    != [] ? 2    :
    search("1", code)    != [] ? 1    :
    undef;

// Main helper module. `profile` selects the keycap profile such as
// "dcs", "sa", etc. The key code determines row sculpting and key
// width. If additional transformations or legends are needed they can
// be chained before calling `key()`.
module uhk80(code, profile="dcs") {
  row = _uhk80_row(code);
  width = _uhk80_width(code);
  if (row == 0 || width == undef) {
    echo(str("uhk80: unknown key code ", code));
  } else {
    key_profile(profile, row) u(width) {
      if ($children) {
        children();
      } else {
        key();
      }
    }
  }
}
