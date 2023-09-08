// Shelf width
shelf_width = 85; // [3:100]

// Shelf back height
shelf_back_height = 58; // [30:80]

// Depth of shelf
shelf_depth = 28; // [10:30]

// Angle of shelf
shelf_angle = 55; // [30:75]

// Shelf padding from bottom
shelf_padding_height = 14; // [0:20]

// Thickness of surfaces
thickness = 3; // [3:6]

// Height of the front
front_height = shelf_padding_height + shelf_depth * cos(shelf_angle);

// Depth of the corner of the shelf
shelf_corner_depth = shelf_depth * sin(shelf_angle);

// Depth of holder to support the back height
holder_depth = shelf_corner_depth + shelf_back_height * cos(shelf_angle);

// Height of the back
back_height = shelf_padding_height + (holder_depth - shelf_corner_depth) * tan(shelf_angle);

// Corner points
point_top_front = [front_height, 0, 0];
point_shelf_bottom = [shelf_padding_height, shelf_corner_depth, 0];
point_shelf_top = [back_height, holder_depth, 0];
point_bottom_back = [0, holder_depth, 0];

// Rounding of edges
$fn = $preview ? 16 : 64;

union() {
  for (i = [[[0, 0, 0],          point_top_front],
            [point_top_front,    point_shelf_bottom],
            [point_shelf_bottom, point_shelf_top],
            [point_shelf_top,    point_bottom_back],
            [point_bottom_back,  [0, 0, 0]]]) {
    hull() {
      translate(i[0]) cylinder(d=thickness, h=shelf_width);
      translate(i[1]) cylinder(d=thickness, h=shelf_width);
    }
  }
}
