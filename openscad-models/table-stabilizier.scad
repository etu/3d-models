// Height between base and table
base_height = 23;

// Width of the base cube, this includes the margin/feet around the plank for stabilization
base_width = 33;

// With of item to have a strong cube shape
base_depth = 23;

// How far the stabilizers to down
cutout_height = 10;

// With of plank to put base against
cutout_width = 23;

difference() {
  cube([base_width, base_depth, base_height+cutout_height]);
  translate([(base_width - cutout_width)/2,-1,-1]) cube([cutout_width, base_depth+2, cutout_height+1]);
}
