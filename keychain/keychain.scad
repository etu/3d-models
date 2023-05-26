text_string = "My Keychain"; // Text label
text_size = 5;
text_height = 1;

key_depth = text_size*2; // Depth of the keychain
key_width = 45; // Width of the keychain
key_height = 2; // Height of the keychain

ring_diameter = 6;
ring_thickness = 2;

$fn = 64;

module keychain() {
  translate([key_width/-2, key_depth/-2, 0]) cube([key_width, key_depth, key_height]);
  translate([0,0,key_height]) linear_extrude(text_height) text(text_string, size=text_size, halign="center", valign="center");

  translate([key_width/2+ring_diameter/2-ring_thickness/2,0,0]) difference() {
    cylinder(h=key_height, d=ring_diameter);
    translate([0,0,-1]) cylinder(h=key_height+2, d=ring_diameter-ring_thickness);
  }
}

keychain();
