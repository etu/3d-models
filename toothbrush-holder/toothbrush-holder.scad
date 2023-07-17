$fn = 128;

difference() {
  // Make the base resized (tall) sphere
  resize([40,40,80]) sphere(d=40);

  // Cut out top and bottom of base sphere
  translate([-50,-50,20]) cube(100);
  translate([-50,-50,-120]) cube(100);

  // Cut out hole for toothbrush
  translate([0,0,-9]) cylinder(d=15, h=30);

  // Cut out hole for drainage at bottom
  translate([0,0,-21]) cylinder(d=10, h=14);

  // Drainage at the bottom
  translate([-20,0,-20]) rotate([0,90,0]) cylinder(d=10, h=40);
  translate([0,20,-20]) rotate([90,0,0]) cylinder(d=10, h=40);
}
