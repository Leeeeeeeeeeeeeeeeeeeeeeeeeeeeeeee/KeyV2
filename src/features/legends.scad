module keytext(text, position, font_size, depth) {
  woffset = (top_total_key_width()/3.5) * position[0];
  hoffset = (top_total_key_height()/3.5) * -position[1];

  // When legends are outset, only extend just through the key top
  // so the text breaks the surface without reaching the bottom.
  z_offset = $outset_legends ? -$keytop_thickness : -depth;
  extrude_height = $outset_legends ? $keytop_thickness + $dish_depth : $dish_depth + depth;

  translate([woffset, hoffset, z_offset]) {
    color($tertiary_color) linear_extrude(height=extrude_height) {
      text(text=text, font=$font, size=font_size, halign="center", valign="center");
    }
  }
}

module legends(depth=0) {
  if (len($front_legends) > 0) {
    front_of_key() {
      for (i=[0:len($front_legends)-1]) {
        rotate([90,0,0]) keytext($front_legends[i][0], $front_legends[i][1], $front_legends[i][2], depth);
  	  }
    }
  }
  if (len($legends) > 0) {
    top_of_key() {
      for (i=[0:len($legends)-1]) {
        keytext($legends[i][0], $legends[i][1], $legends[i][2], depth);
      }
    }
  }
}
