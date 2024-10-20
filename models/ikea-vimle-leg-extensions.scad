$fn = $preview ? 32 : 128;

// Original leg sizes
original_leg_height = 60.1; // 6cm
original_leg_top_diameter = 50.2; // 5cm
original_leg_bottom_diameter = 45.7; // 4.5cm

// Leg extension sizes
total_height = 115; // 11.5cm
thickness = 4; // 0.4cm

module originalLeg() {
  cylinder(
    d1 = original_leg_bottom_diameter,
    d2 = original_leg_top_diameter,
    h = original_leg_height
  );
}

module legExtension() {
  difference() {
    cylinder(
      d1 = original_leg_bottom_diameter + thickness * 2,
      d2 = original_leg_top_diameter + thickness * 2,
      h = total_height
    );
    translate([
      0,
      0,
      total_height - original_leg_height + 0.1
    ]) originalLeg();

    translate([0,0,-1]) cylinder(h = total_height, d = 20);
  }
}

legExtension();
