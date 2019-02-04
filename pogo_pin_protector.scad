pin_spacing = 2.54;
pin_grid = [3, 2];
pin_diameter_top = 1.5;
pin_diameter_bottom = 2;
pin_height = 20.5;
extra_width = 1;


plate_height = 1;
screw_hole_spacing = 11;
screw_hole_offset = 5;
screw_hole_extra = 4;
screw_hole_size = 3.3;

$fn=60;
smidge = 0.01;

difference() {
  union() {
    minkowski() {
      translate([1 -(pin_grid.x * pin_spacing / 2) - extra_width/2, 1- extra_width/2, 0])
        cube([pin_grid.x * pin_spacing - 2 + extra_width,
              pin_grid.y * pin_spacing - 2 + extra_width,
              pin_height]);
      cylinder(r=1, h=smidge);
    }
    minkowski() {
      translate([-(screw_hole_spacing + screw_hole_extra) / 2, 0, 0])
      cube([screw_hole_spacing + screw_hole_extra,
            (pin_grid.y - 1) * pin_spacing + screw_hole_offset + screw_hole_extra,
            plate_height]);
        cylinder(r=1, h=smidge);
      }

  }

  translate([pin_spacing/2 - (pin_grid.x * pin_spacing / 2), pin_spacing/2 , 0])
    for (y = [0 : pin_spacing : (pin_grid.y - 1) * pin_spacing])
      for (x = [0 : pin_spacing : (pin_grid.x - 1) * pin_spacing])
        translate([x, y, -smidge])
          cylinder(d2=pin_diameter_top, d1=pin_diameter_bottom, h=pin_height + smidge*3);

    translate([-screw_hole_spacing / 2, pin_spacing * pin_grid.y - 1 + screw_hole_offset, -smidge])
      cylinder(d=screw_hole_size, h=plate_height + smidge * 3);
    translate([screw_hole_spacing / 2, pin_spacing * pin_grid.y - 1 + screw_hole_offset, -smidge])
      cylinder(d=screw_hole_size, h=plate_height + smidge * 3);
}
