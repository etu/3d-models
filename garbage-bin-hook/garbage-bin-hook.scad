// Rounding of edges
$fn = 64; // [12:128]

rotate([0,-90,0]) difference() {
  union() {
    // Cylinder that goes through the hole
    translate([0,0,5]) cylinder(h=16, d=25);

    // Cylinder that holds the bin
    hull() {
      translate([0,0,18]) cylinder(h=5, d=25);
      translate([5,0,18]) cylinder(h=5, d=25);
    }

    // This creates the back mounted to the door under the sink
    hull() {
      translate([25,0,-5]) cylinder(d=15, h=15);
      translate([0,0,-5]) cylinder(d=25, h=15);
    }
  }

  // Cut away bottom of cylinders
  translate([-13,-16,-6]) cube([13,30,32]);

  // Cut away screw hole
  translate([25,0,-6]) cylinder(d=4, h=17);
}
