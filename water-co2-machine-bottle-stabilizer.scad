olength = 72;
owidth = 61;
odepth = 13;

$fn = 128;

difference() {
  union() {
    // Base that lives in the hole
    hull() {
      cylinder(d=owidth, h=odepth);
      translate([olength - owidth,0,0]) cylinder(d=owidth, h=odepth);
    }
    // A brim on top of the base to not fall through
    hull() {
      translate([0,0,odepth]) cylinder(d=owidth+4, h=2);
      translate([olength - owidth, 0, odepth]) cylinder(d=owidth+4, h=2);
    }
  }

  // Hole to cut out of the base and the brim.
  hull() {
    translate([5,0,-1]) cylinder(d=61, h=odepth+4);
    translate([10,0,-1]) cylinder(d=61, h=odepth+4);
  }

  // Fully cut out some of the sides.
  translate([0,-owidth/2-1,-1]) cube([30, owidth+2, odepth+1]);
}
