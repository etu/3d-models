// Rounding of edges
$fn = $preview ? 16 : 128;

// Attribution: Rock_wall_hold_knob_5.stl is downloaded from:
// https://www.printables.com/model/309327
module scaledHold() {
  scale([0.6,0.6,0.6]) import("Rock_wall_hold_knob_5.stl");
}

difference() {
  scaledHold();

  // Hole from bottom
  translate([-3.3, -9.5, -1]) cylinder(h = 5, r1 = 3, r2 = 2);

  // Hole from top
  translate([-3.3, -9.5, 4]) cylinder(h = 5, r1 = 2, r2 = 3);
}
