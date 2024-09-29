// Quality of spheres
$fn = 128; // [32:128]

// Thickness
thickness = 4; // mm
height = 20; // mm

module cornerGrip() {
  // Inner size of corner to grip on to
  backWidth = 18.2; // mm
  backHookDepth = 6.9; // mm
  sideDepth = 36.2; // mm
  sideHook = 7.3; // mm

  // Shorthand for easier points bellow
  r = thickness / 2;

  for (i = [[[-r, r + sideDepth - backHookDepth], [-r, r + sideDepth]],
            [[-r, r + sideDepth],                 [r + backWidth, r + sideDepth]],
            [[r + backWidth, r + sideDepth],      [r + backWidth, -r]],
            [[r + backWidth, -r],                 [r + backWidth - sideHook, -r]]]) {
    hull() {
      translate(i[0]) cylinder(d = thickness, h = height);
      translate(i[1]) cylinder(d = thickness, h = height);
    }
  }
}

module powerStripGrips() {
  // Sizes
  slideWidth = 48.9; // mm
  slideHookDepth = 2.4; // mm
  slideHookTeeth = 3.2; // mm
  slideHookMaxThickness = 1.8; // mm

  // Shorthand for easier points bellow
  r1 = thickness / 2;
  r2 = slideHookMaxThickness / 2;

  for (i = [[[r2 + slideHookDepth, -r2 + slideHookTeeth, slideHookMaxThickness], [r2 + slideHookDepth, -r2, slideHookMaxThickness]],
            [[r2 + slideHookDepth, -r2, slideHookMaxThickness],                  [-r1, -r1, thickness]],
            [[-r1, -r1, thickness],                                              [-r1, slideWidth + r1, thickness]],
            [[-r1, slideWidth + r1, thickness],                                  [slideHookDepth + r2, slideWidth + r2, slideHookMaxThickness]],
            [[slideHookDepth + r2, slideWidth + r2, slideHookMaxThickness],      [slideHookDepth + r2, slideWidth + r2 - slideHookTeeth, slideHookMaxThickness]]]) {
    hull() {
      translate([i[0][0], i[0][1]]) cylinder(d = i[0][2], h = height);
      translate([i[1][0], i[1][1]]) cylinder(d = i[1][2], h = height);
    }
  }
}

union() {
  translate([-thickness - 18.2,12.7,0]) cornerGrip();
  powerStripGrips();
}
