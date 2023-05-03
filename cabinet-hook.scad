translate([1,14,23.5]) rotate([-90,0,0]) union() {
  // Back-side hook.
  translate([-0.5,0,0]) difference() {
    // Base cube
    cube([11, 7.3, 6.8]);

    // Cut out outer sides to make two hooks
    translate([-1,-1,-1]) cube([2,9.3,5]);
    translate([10,-1,-1]) cube([2,9.3,5]);

    // Cut out inner bit as well
    translate([2.25,-1,-1]) cube([6.5, 9.3,8.8]);
  }

  // Hook back
  translate([-1,-1,-4]) cube([12, 24.5, 4]);

  // Hook base
  translate([-1,19.5,-14]) cube([12, 4, 10]);

  // Hook front
  translate([-1,9.5,-14]) cube([12,10,4]);
}
