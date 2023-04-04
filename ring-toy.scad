inner_ring_size = 21; // Inner size in mm (diameter of inner ring);
wall_thickness = 4.25; // Wall thickness on the spheres;
space_between_rings = 0.5; // Space between rings;
height = 16; // Height of the result;
ring_count = 4; // Amount of rings;

$fn = 128; // Quality of spheres;

module ring(radius) {
  difference() {
    // Render outer sphere
    sphere(radius);

    // Render inner sphere to remove
    sphere(radius - wall_thickness);

    // Render a cube above and below to remove to make a ring
    translate([0,0,radius+(height/2)+1]) cube((radius*2)+2, center = true);
    translate([0,0,-radius-(height/2)-1]) cube((radius*2)+2, center = true);
  }
}

for (i = [0:ring_count]) {
  ring((inner_ring_size / 2) + (wall_thickness + space_between_rings) * i);
}
