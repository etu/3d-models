// Holder widths
holderWidths = 40;

// Holder depths
holderDepths = 60;

// Holder thickness
holderThickness = 14;

// Holder heights in the base holder
holderHeightsBase = 40;

// Holder heights in the top holder
holderHeightsTop = 30;

// Diameter of screw hole size
screwHoleDiameter = 4;

// Screw driver hole size
screwDriverHoleSize = 12;

// Spacing between objects
distanceBetweenObjectsInPreview = 4;

// Rounding of edges
$fn = $preview ? 16 : 32;

module topHook() {
  difference() {
    // Base cube
    cube([
      holderWidths + holderThickness,
      holderDepths + holderThickness * 2,
      holderHeightsTop
    ]);

    // Cut out paper holder
    translate([
      holderThickness + 1,
      holderThickness,
      -1
    ]) cube([
      holderWidths + 1,
      holderDepths,
      holderHeightsTop + 2
    ]);

    // Cut out screw hole
    translate([
      (holderThickness + holderWidths) / 2, // Centering of hole
      holderDepths + holderThickness * 2 + 1, // Depth of hole
      holderHeightsTop * 0.65 // Height of hole
    ]) rotate([90,0,0]) cylinder(
      d=screwHoleDiameter,
      h=holderDepths + holderThickness * 2 + 2
    );

    // Cut out screw driver hole
    translate([
      (holderThickness + holderWidths) / 2, // Centering of hole
      holderDepths + holderThickness * 1 + 1, // Depth of hole
      holderHeightsTop * 0.65 // Height of hole
    ]) rotate([90,0,0]) cylinder(
      d=screwDriverHoleSize,
      h=holderDepths + holderThickness * 1.5
    );
  }
}

module bottomHook() {
  difference() {
    // Base cube
    cube([
      holderWidths + holderThickness,
      holderDepths + holderThickness * 2,
      holderHeightsBase + holderThickness
    ]);

    // Cut out paper holder
    translate([
      holderThickness + 1,
      holderThickness,
      holderThickness + 1
    ]) cube([
      holderWidths + 1,
      holderDepths,
      holderHeightsBase + 1
    ]);
 
    // Cut out screw hole
    translate([
      (holderThickness + holderWidths) / 2, // Centering of hole
      holderDepths + holderThickness * 2 + 1, // Depth of hole
      holderHeightsBase * 0.85 // Height of hole
    ]) rotate([90,0,0]) cylinder(
      d=screwHoleDiameter,
      h=holderDepths + holderThickness * 2 + 2
    );

    // Cut out screw driver hole
    translate([
      (holderThickness + holderWidths) / 2, // Centering of hole
      holderDepths + holderThickness * 1 + 1, // Depth of hole
      holderHeightsBase * 0.85 // Height of hole
    ]) rotate([90,0,0]) cylinder(
      d=screwDriverHoleSize,
      h=holderDepths + holderThickness * 1.5
    );
  }
}

// Render the top hook
translate([(holderWidths+holderThickness)*2+distanceBetweenObjectsInPreview,0,0])
mirror([1,0,0])
translate([0,holderDepths + holderThickness * 2 + distanceBetweenObjectsInPreview,0])
topHook();

// Render the top hook
translate([0,holderDepths + holderThickness * 2 + distanceBetweenObjectsInPreview,0])
topHook();



// Render the bottom hook
bottomHook();

// Render the mirrored bottom hook
translate([(holderWidths + holderThickness)*2+distanceBetweenObjectsInPreview,0,0])
mirror([1,0,0]) bottomHook();