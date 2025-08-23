// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

include <./includes.scad>
include <./uhk80.scad>

$outset_legends = true;
$support_type = "disable";
$stem_support_type = "disable";
$stabilizer_type = "disable";

// arrow key cluster with raised legends
R4XU1() legend("←") key();
translate_u(1,0) R4XU1() legend("↓") key();
translate_u(2,0) R4XU1() legend("→") key();
translate_u(1,1) R4U1() legend("↑") key();
