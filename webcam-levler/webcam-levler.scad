// Base of camera is 58mm
base_width = 58;

// Enough height so camera hook doesn't cover the screen
base_height = 4;

// About the same depth as the flat area on top of my screen
base_depth = 12;

// Same height as the thickness of the camera mount
side_wall_height = 6;

// Thickness of the side walls
side_wall_width = 4;

// Thickness of the hooks
front_hook_depth = 4;

// Depth of the hooks
front_hook_size = 4;

union() {
  // Make base
  cube([base_width + (side_wall_width * 2), base_depth, base_height]);

  // Add side walls
  cube([side_wall_width, base_depth, side_wall_height + base_height]);
  translate([base_width + side_wall_width, 0, 0]) cube([side_wall_width, base_depth, side_wall_height + base_height]);

  // Add Front hooks
  translate([0,-front_hook_depth,-front_hook_size]) cube([side_wall_width,front_hook_depth,front_hook_size+base_height+side_wall_height]);
  translate([base_width + side_wall_width,-front_hook_depth,-front_hook_size]) cube([side_wall_width,front_hook_depth,front_hook_size+base_height+side_wall_height]);
}
