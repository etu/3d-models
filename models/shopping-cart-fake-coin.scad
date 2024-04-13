// Thickness
thickness = 3;

// Quality of spheres
$fn = 64; // [16:128]

union() {
  // Main coin part
  cylinder(d=20.5, h=thickness);

  // Bar between coin and grip
  translate([6,-4.5,0]) cube([9,9,thickness]);

  // Grip
  translate([20,0,0]) difference() {
    cylinder(d=15, h=thickness);
    translate([0,0,-1]) cylinder(d=9, h=thickness+2);

    // Cut out of ring
    translate([3.5,-1,-1]) cube([5,2,thickness+2]);
  }
}
