// Inner size in mm (diameter of inner ring)
inner_ring_size = 21; // [18:24]

// Wall thickness on the spheres
wall_thickness = 4.25;

// Spacing between rings
space_between_rings = 0.5;

// Height of the result
height = 16; // [13:20]

// Amount of rings (including the middle bit)
ring_count = 5; // [1:7]

// Quality of spheres
$fn = 128; // [32:128]

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

for (i = [0:ring_count-1]) {
  ring((inner_ring_size / 2) + (wall_thickness + space_between_rings) * i);
}
