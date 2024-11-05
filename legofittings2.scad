use <abbl-base.scad>

hole_size=10.5;

module connectora() {
    difference() {
        union() {
            translate([0,0,-((hole_size + 3)/2-4)]) rounded_beam(5);
            minkowski() {
                cube([19,hole_size+1,hole_size+1], center=true);
                sphere(1, $fn=30);
            }
        }
        cylinder(h=20 , r=hole_size/2 ,center=true, $fn=30);
        translate([-8,0,0]) rotate([0,90,0]) cylinder(h=10 , r=1.5 ,center=true, $fn=30);

    }
}

module connectorb() {
    difference() {
        union() {
            translate([0,0,-((hole_size + 3)/2-4)]) rounded_beam(5);
            minkowski() {
                cube([19,hole_size+1,hole_size+1], center=true);
                sphere(1, $fn=30);
            }
        }
        translate([-2,0,0])rotate([0,90,0]) cylinder(h=20 , r=hole_size/2 ,center=true, $fn=30);
        translate([0,0,-8])  cylinder(h=10 , r=1.5 ,center=true, $fn=30);

    }
}

//translate([0,10,0]) connectora();


translate([0,-10,0]) connectorb();
translate([0,10,0]) connectorb();
translate([0,30,0]) connectorb();
translate([0,-30,0]) connectorb();
translate([0,50,0]) connectorb();
translate([0,-50,0]) connectorb();

translate([50,0,0]){
translate([0,-10,0]) connectorb();
translate([0,10,0]) connectorb();
translate([0,30,0]) connectorb();
translate([0,-30,0]) connectorb();
translate([0,50,0]) connectorb();
translate([0,-50,0]) connectorb();
}