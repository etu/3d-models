// Rounding of edges
$fn = $preview ? 16 : 128;

// Attribution: elephant_stand.stl is downloaded from:
// https://www.printables.com/model/439440-cute-elephant-phone-stand

difference() {
  union() {
    // Import elephant stand stl
    scale([0.3, 0.3, 0.1785715]) import("elephant_stand.stl");

    // Make a pipe through the elephant to make a channel for threads
    hull() {
      intersection() {
        // So we import the elephant again
        scale([0.3, 0.3, 0.1785715]) import("elephant_stand.stl");
        // And do an intersection with a cylinder
        translate([-15,3,2.5]) rotate([0,90,6]) cylinder(h=30, d=3);
      }
      // We then hull it to get a solid pipe
    }
    // That we union with the main elephant
  }

  // And then cut out hole for pearl
  translate([-15,3,2.5]) rotate([0,90,6]) cylinder(h=30, d=2);
}
