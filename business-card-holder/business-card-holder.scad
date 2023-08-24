$fn = 64;

union() {
  for (i = [// Bottom front, Top front
            [[0, 0, 0],      [33, 0, 0]],
            // Top front,    Shelf bottom
            [[33, 0, 0],     [14, 20.5, 0]],
            // Shelf bottom, Shelf top
            [[14, 20.5, 0],  [51, 57, 0]],
            // Shelf top,    Bottom back
            [[51, 57, 0],    [0, 57, 0]],
            // Bottom back,  Bottom front
            [[0, 57, 0],     [0, 0, 0]]]) {
    hull() {
      // Card width is 85mm and surface thickness becomes 3mm
      translate(i[0]) cylinder(d=3, h=85);
      translate(i[1]) cylinder(d=3, h=85);
    }
  }
}
