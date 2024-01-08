// Height of bead in mm (before scaled down)
beadHeight = 40;

// Bead hole diameter in mm (before scaled down)
beadHoleDiameter = 30;

// Scale factor to resize the final object
scaleFactor = 0.125;

// Rounding of edges
$fn = $preview ? 16 : 128;

// Build a nix lambda
module nixLambda() {
  polygon([
    [4,0],
    [0,7],
    [13.2,29.9],
    [3.8,46],
    [11.7,59.9],
    [46.4,0.1],
    [30.4,0],
    [21.15,16.1],
    [12,0]
  ]);
}

// Vase
scale([scaleFactor, scaleFactor, scaleFactor])
difference() {
  linear_extrude(height=beadHeight) union() {
    nixLambda();

    translate([70,-3,0]) rotate([0,0,60])
    nixLambda();

    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    nixLambda();

    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    nixLambda();

    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    nixLambda();

    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    translate([70,-3,0]) rotate([0,0,60])
    nixLambda();
  }

  translate([20,-10,beadHeight/2])
  rotate([-90,0,-15])
  cylinder(h=150, d=beadHoleDiameter);
}
