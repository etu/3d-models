inner_width = 79; // Inner width in milimeters.
inner_height = 56; // Inner height in milimeters.
inner_depth = 20; // Inner depth in milimeters.
wall_thickness = 3; // Wall thickness in milimeters.
rounding_radius = 15;

$fn = 64;

// TODO:
// - Make lid for pipes at top

module roundedCube(extraSize = 0) {
  // Adjust the location since the sphere builds out the cube.  Then
  // use minkowski and a sphere to make a rounded cube.
  translate([rounding_radius,rounding_radius,0]) minkowski() {
    // Make a cube matching the inner sizes on the width, height and
    // depth, but remove some of the rounding radius to make it the
    // correct size.
    cube([
      inner_width-rounding_radius*2+extraSize,
      inner_depth-rounding_radius+extraSize,
      inner_height-rounding_radius+extraSize
    ]);
    sphere(r=rounding_radius);
  }
}

module roundedShell() {
  // Make a rounded shell.
  intersection() {
    // So here we make two rounded cubes, one bigger and one smaller
    // and takes the difference of those. This way we get an empty
    // rounded cube.
    translate([wall_thickness,wall_thickness]) difference() {
      translate([-wall_thickness, -wall_thickness, -wall_thickness]) roundedCube(wall_thickness*2);
      roundedCube();
    }
    // Then we use intersection and a cube to only keep the part of
    // the shell that we want to have.
    translate([-1,-1,0]) cube([
      inner_width+wall_thickness*2+2,
      inner_depth+wall_thickness+2,
      inner_height+wall_thickness+2
    ]);
  }
}

module pipes() {
  intersection() {
    // Make two pipes out of a cube and a cylinder.
    union() {
      hull() {
        translate([17,1,0]) cube([10, 7, inner_height+wall_thickness+1]);
        translate([22,13,0]) cylinder(d=10, h=inner_height+wall_thickness+1);
      }
      translate([41,0,0]) hull() {
        translate([17,1,0]) cube([10, 7, inner_height+wall_thickness+1]);
        translate([22,13,0]) cylinder(d=10, h=inner_height+wall_thickness+1);
      }
    }
    // Generate a rounded cube and intersect it with the pipes to make
    // them flush against the shell.
    translate([-wall_thickness, wall_thickness, -wall_thickness]) roundedCube(wall_thickness*2);
  }
}

module pipeHoles() {
  union() {
    // First pipe
    translate([22,10,-1]) cylinder(d=4, h=7, center=false);
    translate([22,10,5]) cylinder(d=7, h=inner_height, center=false);
    translate([18.5,3,5]) cube([7, 7, inner_height]);
    // Second pipe
    translate([41+22,10,-1]) cylinder(d=4, h=7, center=false);
    translate([41+22,10,5]) cylinder(d=7, h=inner_height, center=false);
    translate([41+18.5,3,5]) cube([7, 7, inner_height]);
  }
}

module bottomWalls() {
  intersection() {
    translate([15,15,0]) cylinder(r=15, h=3, center=false);
    translate([0,0,-1]) cube([22,18,5]);
  }
  translate([85,0,0]) mirror([1,0,0]) intersection() {
    translate([15,15,0]) cylinder(r=15, h=3, center=false);
    translate([0,0,-1]) cube([22,18,5]);
  }
}

module bottomRidge() {
  translate([30,2,-3]) cube([26,1,4]);
}

difference() {
  union() {
    roundedShell();
    pipes();
    bottomWalls();
    bottomRidge();
  }
  pipeHoles();
}
