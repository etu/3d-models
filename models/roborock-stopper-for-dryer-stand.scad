width = 34;
height = 45;
depth = 11;

// Quality of spheres
$fn = 128; // [32:128]

side_text = "elis.nu";

module feetCutout() {
    difference() {
        translate([-1,0,-1]) cube([6, height+1, depth+2]);
        translate([4,0,-2]) cylinder(depth+4, 4, 4);
        translate([4,-1,-2]) cube([7, 5, depth+4]);
    };
}

module pipeCutout() {
    // Make a cube to cut out from for the pipe to slide in through.
    translate([10, -1, -1]) cube([14, 11, depth+2]);

    difference() {
        // Make a cylinder to cut out so the pipe fits.
        translate([17, 14, -1]) cylinder(depth+2, 8, 8);
        // Make a cube to cut out from the cylinder that goes into the side hole of the pipe.
        translate([14, 15, -2]) rotate(48) cube([2, 6, depth+4]);
    }
}

module topCutout() {
    translate([17, 47, -1]) scale([1, 2.5, 1]) cylinder(depth+2, 9, 9);
}

module topRoundedCorner() {
    difference() {
        translate([4,height-2,-1]) cube([5,3,depth+4]);
        translate([6.6,height-2,-2]) cylinder(depth+6, 1.6, 1.6);
    }
}

module sideText() {
    translate([6,37,2]) scale(0.7) rotate([90,0,270]) linear_extrude(2) text(side_text);

    translate([28,10,2]) scale(0.7) rotate([90,0,90]) linear_extrude(2) text(side_text);
}

difference() {
    // Render base cube
    cube([width, height, depth]);

    // Render left feet cutout
    feetCutout();
    // Render right feet cutout
    translate([width, 0, 0]) mirror([1,0,0]) feetCutout();

    // Render pipe cutout
    pipeCutout();

    // Render top cutout
    topCutout();

    // Render left top runded corner cutout
    topRoundedCorner();

    // Render right top rounded corner cutout
    translate([width, 0, 0]) mirror([1,0,0]) topRoundedCorner();

    // Render side text for cut out
    sideText();
};
