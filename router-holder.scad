router_width = 190;
router_height = 39;
holder_width = 10;
holder_thickness = 3;
holder_hole = 6;

$fn = 128;

module sideHole() {
  translate([0,holder_width/2,0]) difference() {
    // Make the side bit.
    union() {
      translate([holder_width/2,0,0]) cylinder(d=holder_width, h=holder_thickness);
      cube([holder_width, holder_width-holder_thickness, holder_thickness]);
    }

    // Difference out the hole.
    translate([holder_width/2,0,-1]) cylinder(d=holder_hole,h=holder_thickness+2);
  }
}

module bracket() {
  union() {
    // Bar going across the router
    translate([0,holder_width,router_height]) cube([holder_width, router_width+holder_thickness, holder_thickness]);

    // Bars going down to screw holes
    translate([0,holder_width,0]) cube([holder_width,holder_thickness,router_height+holder_thickness]);
    translate([0,router_width+holder_width,0]) cube([holder_width,holder_thickness,router_height+holder_thickness]);
  }
}

sideHole();
translate([0,router_width+holder_width*2+holder_thickness,0]) mirror([0,1,0]) sideHole();
bracket();
