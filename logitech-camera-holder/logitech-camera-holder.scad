height = 36/2;
depth = 26;
width = 92;
wall_thickness = 2;

// Rounding of edges
$fn = $preview ? 32 : 128;

module top() {
  difference() {
    // Body cube
    cube([width,depth,height]);

    // Cut out contents
    translate([wall_thickness,wall_thickness,-2])
      cube([width-wall_thickness*2,depth-wall_thickness*2,height]);

    // Cut out shadow line
    translate([wall_thickness/2-0.25,wall_thickness/2-0.25,-1])
      cube([width-wall_thickness+0.5, depth-wall_thickness+0.5, 2]);

    // Cut out main camera hole
    difference() {
      // Cylinder to cut out front for camera
      translate([46.3, 3, -2.7]) rotate([90,0,0]) cylinder(d=69.4,h=wall_thickness+2);

      // Cube to cut out top of cylinder
      translate([0,-2,height-wall_thickness-1]) cube([width, wall_thickness+4, 20]);
    }

    // Cut out shadow line behind main camera hole
    difference() {
      // Cylinder to cut out front for camera
      translate([46.3, 5-0.25, -2.7]) rotate([90,0,0]) cylinder(d=69.4+2,h=wall_thickness+2);

      // Cube to cut out top of cylinder
      translate([0,0,height-wall_thickness-0.25]) cube([width, wall_thickness+4, 20]);
    }

    // Make a hole cutout
    translate([76,27,0]) rotate([90,0,0]) hull() {
      translate([0,0,0]) cylinder(d=8,h=4);
      translate([4.5,0,0]) cylinder(d=8,h=4);
    }
  }
}

module bottom() {
  difference() {
    union() {
      // Body cube
      cube([width,depth,height]);

      // Add Shadow line buildup
      translate([wall_thickness-0.5,wall_thickness-0.5,height])
      cube([width-wall_thickness*2+1, depth-wall_thickness*2+1, 1]);

      // Mounting hole on bottom
      translate([82/2,13,-6]) rotate([0,90,0]) difference() {
        hull() {
          translate([-7,-3.5,0]) cube([7,7,10]);
          cylinder(d=7, h=10);
        }
        translate([0,0,-1]) cylinder(d=5, h=12);
      }
    }

    // Cut out contents
    translate([wall_thickness,wall_thickness,2])
      cube([width-wall_thickness*2,depth-wall_thickness*2,height]);

    // Cut out main camera hole
    difference() {
      // Cylinder to cut out front for camera
      translate([46.3, 3, 20-2.7]) rotate([90,0,0]) cylinder(d=69.4,h=wall_thickness+2);

      // Cube to cut out bottom of cylinder
      translate([0,-2,-17.75]) cube([width, wall_thickness+4, 20]);
    }

    // Cut out main camera hole
    difference() {
      // Cylinder to cut out front for camera
      translate([46.3, 4.75, 17.25]) rotate([90,0,0]) cylinder(d=69.4+2,h=wall_thickness+2);

      // Cube to cut out bottom of cylinder
      translate([0,-2+0.25,-18]) cube([width, wall_thickness+5, 20]);
    }

    // Make a hole cutout
    translate([76,27,18]) rotate([90,0,0]) hull() {
      translate([0,0,0]) cylinder(d=8,h=4);
      translate([4.5,0,0]) cylinder(d=8,h=4);
    }
  }
}

module base() {
  translate([17,7,12]) union() {
    // Basic arms.
    cube([3+72.5+3-14-1.7, 6, 3]);
    cube([6,6+73-14,3]);

    // Arm end grips
    translate([72.5+3-14-1.7,0,-12]) cube([3,6,12]);
    translate([0,73-14+3,-12]) cube([6,3,12]);

    // Left core grip
    translate([-6-11+1.7,6,0]) cube([9+11,6,3]);
    translate([-6-11+1.7,6,-12]) cube([3,6,12]);

    // Front core grip
    translate([6,-6-7-2,0]) cube([6,9+7,3]);
    translate([6,-6-7-2,-12]) cube([6,3,12]);

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

top();
translate([0,28,0]) bottom();
translate([0,65,0]) base();
