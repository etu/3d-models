wall_thickness = 2;
wiggly = 0.2;
$fn = 128;

module front() {
  translate([2,0,2]) union() {
    // Front to have around camera
    difference() {
      cube([85.6, wall_thickness, 30.4+wiggly]);
      translate([85.6/2,3,-2.8+66.4/4]) rotate([90,0,0]) cylinder(d=66.4,h=wall_thickness+2);
    }

    // Upper and lower wall
    translate([0,0,-wall_thickness]) cube([85.6,22,wall_thickness]);
    translate([0,0,30.4+wiggly]) cube([85.6,22,wall_thickness]);

    // Left and right wall
    translate([-wall_thickness,0,-wall_thickness]) cube([wall_thickness,22,30.4+wiggly+wall_thickness*2]);
    translate([85.6,0,-wall_thickness]) cube([wall_thickness,22,30.4+wiggly+wall_thickness*2]);
  }
}

module back() {
  union() {
    // Base outside of back cube
    difference() {
      cube([85.6+wall_thickness*4+wiggly*2,22+wall_thickness+wiggly,30.4+wall_thickness*4+wiggly*2]);
      translate([wall_thickness,-1,wall_thickness]) cube([85.6+wall_thickness*2+wiggly*2,22+1+wiggly*2,30.4+wall_thickness*2+wiggly*2]);

      // Make a hole cutout
      translate([78.0,25,19.85]) rotate([90,0,0]) hull() {
        translate([0,0,0]) cylinder(d=5.3+wiggly*2,h=4);
        translate([4.2,0,0]) cylinder(d=5.3+wiggly*2,h=4);
      }

      // Make a cable cutout
      translate([78.5,-1,-1]) cube([3.1,30,20]);
    }

    // Mounting hole on bottom
    translate([42.8,7,0]) rotate([0,90,0]) difference() {
      translate([0,0,0]) cube([10,10,10]);
      translate([5,5,-1]) cylinder(d=5,h=12);
    }
  }
}

module base() {
  translate([17,7,12]) union() {
    // Basic arms.
    cube([6+72.5+3-14, 6, 3]);
    cube([6,6+73-14+3,3]);

    // Arm end grips
    translate([72.5+3-14,0,-12]) cube([6,6,12]);
    translate([0,73-14+3,-12]) cube([6,6,12]);

    // Left core grip
    translate([-6-11,6,0]) cube([9+11,6,3]);
    translate([-6-11,6,-12]) cube([3,6,12]);

    // Front core grip
    translate([6,-6-7,0]) cube([6,9+7,3]);
    translate([6,-6-7,-12]) cube([6,3,12]);

    // Mounting hole
    translate([12,-2,0]) rotate([0,0,45]) intersection() {
      difference() {
        cube([20,20,20]);
        translate([-1,5,6]) cube([22,10,15]);
        translate([13,21,13]) rotate([90,0,0]) cylinder(d=5, h=22);
      }
      translate([4,21,4]) rotate([90,0,0]) cylinder(d=35, h=22);
    }
  }
}

front();
translate([0,30,0]) back();
translate([0,65,0]) base();
