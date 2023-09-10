// Width of the hook
width = 15; // [13:20]

// Rounding of edges
$fn = 64; // [12:128]

module baseHook() {
  union() {
    difference() {
      hull() {
        // Back against wall
        cube([87,7,width]);
        // Build out for hook from wall
        translate([87/2-11,0,0]) cube([22,15,width]);
      }

      // Cut out for mounting holes
      translate([15,19,width/2]) rotate([90,0,0]) cylinder(d=5, h=20);
      translate([72,19,width/2]) rotate([90,0,0]) cylinder(d=5, h=20);

      translate([15,14,width/2]) rotate([90,0,0]) cylinder(d=11, h=5);
      translate([72,14,width/2]) rotate([90,0,0]) cylinder(d=11, h=5);
    }

    hull() {
      // Back wall cube
      translate([87/2-11,0,0]) cube([22,15,width]);
      // Build out to top front of hook
      translate([87/2-10.5,60.3,0]) cylinder(d=1, h=width);
      // Build out to bottom front of hook
      translate([87/2+10.5,55,0]) cylinder(d=1, h=width);
    }
  }
}

// The hook with the rounded cut out
difference() {
  baseHook();
  translate([32,22+32/2,-1]) cylinder(d=29, h=width+2);
}

// The hook with the cube cut out
translate([0,-65,0]) difference() {
  baseHook();
  translate([31.5,23.5,-1]) cube([15,29,width+2]);
}
