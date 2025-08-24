// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

include <./includes.scad>
include <./uhk80.scad>

// Generate UHK80 layout halves
// Examples:
// uhk80_half("left");   // left side only
// uhk80_half("right");  // right side only
uhk80_half("both");      // render both halves
