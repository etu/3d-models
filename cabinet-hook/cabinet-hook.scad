$fn = 64;

translate([1,14,23.5]) rotate([-90,0,0]) union() {
  // Back-side hook.
  translate([-0.5,0,0]) difference() {
    // Base cube
    cube([11, 7, 6.8]);

    // Cut out outer sides to make two hooks
    translate([-1,-1,-1]) cube([2,9.3,5]);
    translate([10,-1,-1]) cube([2,9.3,5]);

    // Cut out inner bit as well
    translate([2.25,-1,-1]) cube([6.5, 9.3,8.8]);
  }

  // Hook back
  hull() {
    // Bottom
    translate([5,19.5,-4]) cylinder(r=4, h=4);

    // Two top back corners
    translate([1,1,-1]) cylinder(r=2, h=1);
    translate([9,1,-1]) cylinder(r=2, h=1);

    // Two top front corners
    translate([1,1,-2]) sphere(r = 2);
    translate([9,1,-2]) sphere(r = 2);
  }

  // Hook base
  hull() {
    translate([5,19.5,-1]) cylinder(r=4, h=1);
    translate([5,19.5,-10]) sphere(r=4);
  }

  // Hook front
  hull() {
    translate([5,9.5,-12]) sphere(r=2);
    translate([5,19.5,-10]) sphere(r=4);
  }
}
