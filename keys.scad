// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

include <./includes.scad>


// example key
dcs_row(5) legend("⇪", size=9) key();


// example UHK80 key
uhk80("R3U1") legend("A") key();

// example arrow cluster from the UHK80 layout
translate_u(0, 0)    uhk80("R1U1") key();
translate_u(1, 0)    uhk80("R1U1") key();
translate_u(2, 0)    uhk80("R2U1") legend("↑") key();
translate_u(0,-1)    uhk80("R3U1") legend("←") key();
translate_u(1,-1)    uhk80("R4U1") legend("↓") key();
translate_u(2,-1)    uhk80("R4XU1") legend("→") key();

// example row
/* for (x = [0:1:4]) {
  translate_u(0,-x) dcs_row(x) key();
} */

// example layout
/* preonic_default("dcs") key(); */
