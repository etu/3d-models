// Rounding of edges
$fn = $preview ? 16 : 128;

// Attribution: Rock_wall_hold_knob_4.stl is downloaded from:
// https://www.printables.com/model/309327
module scaledHold() {
  scale([0.6,0.6,0.6]) import("Rock_wall_hold_knob_4.stl");
}

difference() {
  scaledHold();

  // Hole from bottom
  translate([-7, -9.5, -1]) cylinder(h = 5, r1 = 4, r2 = 2);

  // Hole from top
  translate([-7, -9.5, 4]) cylinder(h = 5, r1 = 2, r2 = 4);
}
