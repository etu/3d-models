// Outer length
olength = 72;

// Outer width
owidth = 61;

// Outer depth
odepth = 13;

// Quality of spheres
$fn = 128; // [16:128]

difference() {
  union() {
    // Base that lives in the hole
    difference() {
      hull() {
        cylinder(d=owidth, h=odepth);
        translate([olength - owidth,0,0]) cylinder(d=owidth, h=odepth);
      }

      // Fully cut out some of the sides.
      translate([0,-owidth/2-1,-1]) cube([20, owidth+2, odepth+1]);
    }

    // A brim on top of the base to not fall through.
    hull() {
      translate([0,0,odepth]) cylinder(d=owidth+6, h=3);
      translate([olength - owidth, 0, odepth]) cylinder(d=owidth+6, h=3);
    }

    // Add a brim to the bottom to fix the item in place better.
    difference() {
      hull() {
        translate([0,0,-1]) cylinder(d=owidth+1, h=1);
        translate([olength-owidth,0,-1]) cylinder(d=owidth+1, h=1);
      }
      // Fully cut out some of the sides in the bottom brim.
      translate([0,-owidth/2-1,-2]) cube([20, owidth+2, odepth+1]);
    }
  }

  // Hole to cut out of the base and the brim.
  hull() {
    translate([4,0,-2]) cylinder(d=60, h=odepth+6);
    translate([9,0,-2]) cylinder(d=61, h=odepth+6);
  }
}
