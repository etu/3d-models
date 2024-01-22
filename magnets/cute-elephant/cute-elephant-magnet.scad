// Rounding of edges
$fn = $preview ? 16 : 128;

// Attribution: elephant_stand.stl is downloaded from:
// https://www.printables.com/model/439440-cute-elephant-phone-stand

// Original model height
originalHeight = 28;
wantedHeight = 7;

difference() {
  union() {
    // Original elephant
    scale([0.5, 0.5, wantedHeight / originalHeight])
    import("elephant_stand.stl");

    // Magnet holder
    translate([-6,4,0]) cylinder(h=wantedHeight, d=13);
  }

  // Magnet
  translate([-6,4,0.9]) cylinder(h=3.2, d=10.1);
}
