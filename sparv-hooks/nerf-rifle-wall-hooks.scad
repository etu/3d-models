// Rounding of edges
$fn = 128; // [12:128]

// The hook with the rounded cut out
rotate_extrude() translate([2.5,0,0]) difference() {
    polygon(points=[
        [5,0], 
        [25,0],
        [25,60],
        [5,52],
        [5,15],
        [0,15],
        [0,0]]);
    
    translate([25,38,0]) circle(r=14.5);
}

// The hook with the cube cut out
translate([70,0,0]) rotate_extrude() translate([2.5,0,0]) difference() {
    polygon(points=[
        [5,0], 
        [25,0],
        [25,60],
        [5,52],
        [5,15],
        [0,15],
        [0,0]]);
    
    translate([10.5,23.5,0]) color("red") square([15,29]);
}