// Inner diameter
innerDiameter = 40; // [30:50]

// Diameteter of funnel
funnelDiameter = 70; // [50:80]

// Material thickness
materialThickness = 3; // [1:10]

// Funnel tunnel height
funnelTunnelHeight = 10; // [5:15]

// Height of funnel
funnelHeight = 15; // [10:20]

// Rounding of edges
$fn = $preview ? 16 : 64;

// Base
difference() {
  cylinder(d=innerDiameter, h=funnelTunnelHeight);
  translate([0,0,-1]) cylinder(d=innerDiameter-materialThickness/2, h=funnelTunnelHeight+2);
}

difference() {
  translate([0,0,funnelTunnelHeight]) cylinder(d1=innerDiameter, d2=funnelDiameter, h=funnelHeight);
  translate([0,0,funnelTunnelHeight-0.1]) cylinder(d1=innerDiameter-materialThickness/2-0.2, d2=funnelDiameter-materialThickness/2, h=funnelHeight+0.2);
}
