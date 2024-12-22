// Details of cylinders
$fn = $preview ? 16 : 64;

// Create the left side version
module left_side_holder() {
  // Thickness of materials and front hook
  thickness = 4;

  // Holder width
  holder_width = 15;

  // Points
  point_front_hook = [0, -thickness, 0];
  point_front_top = [0, 0, 0];
  point_arm_mount = [63.5, 0, 0];
  point_arm_tip = [46, -69, 0];
  point_arm_hook_start_top = [102, 0, 0];
  point_arm_hook_start_bottom = [102, -thickness, 0];
  point_arm_hook_end_bottom = [126, -thickness, 0];
  point_arm_hook_end_top = [126, 0, 0];

  // Union all objects and move them a little bit to not cover 0,0,0
  translate([5, 0, 0]) union() {
    // Render objects
    for (i = [[point_front_hook, point_front_top],
              [point_front_top, point_arm_mount],
              [point_arm_mount, point_arm_tip],
              [point_arm_mount, point_arm_hook_start_top],
              [point_arm_hook_start_top,point_arm_hook_start_bottom],
              [point_arm_hook_start_bottom,point_arm_hook_end_bottom],
              [point_arm_hook_end_bottom,point_arm_hook_end_top]]) {
      hull() {
        translate(i[0]) cylinder(d=thickness, h=holder_width);
        translate(i[1]) cylinder(d=thickness, h=holder_width);
      }
    }

    // Separate support object to get the angle right on the arm tip.
    hull() {
      translate([43, -69, 0]) cylinder(d=thickness, h=0.1);
      translate([46, -69, 0]) cylinder(d=thickness, h=holder_width);
    }
  }
}

// Make a mirror for the right side object.
module right_side_holder() {
  mirror([1, 0, 0]) left_side_holder();
}

left_side_holder();
right_side_holder();
