// Rounding of edges
$fn = 64; // [12:128]

rotate([0,-90,0]) difference() {
  union() {
    // Cylinder that goes through the hole
    translate([0,0,-1]) cylinder(h=16, d=25);

    // Cylinder that holds the bin
    hull() {
      translate([0,0,12]) cylinder(h=4, d=25);
      translate([5,0,12]) cylinder(h=4, d=25);
    }

    // This creates the back mounted to the door under the sink
    hull() {
      translate([20,0,-5]) cylinder(d=10, h=9);
      translate([0,0,-5]) cylinder(d=25, h=9);
    }
  }

  // Cut away bottom of cylinders
  translate([-13,-15,-6]) cube([13,30,23]);

  // Cut away screw hole
  translate([20,0,-6]) cylinder(d=4, h=11);
}
