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
//translate([0,-10,0]) connectorb();
module endbracket() {
    angle(3, -45) {rounded_beam(4); rotate([0,0,90]) rounded_beam(5);}
    translate([21,0,0])cylinder(h=8, r=10, center=true);
}
module midbracket() {
    angle(2, -45) {rounded_beam(5); rotate([0,0,90]) rounded_beam(4);}
    rotate([0,0,135])rounded_beam(4); 
    rotate([0,0,225]) rounded_beam(5);
    //translate([4,-16,0])cube([36,4,8], center=true);
    //translate([4,16,0])cube([36,4,8], center=true);
    translate([5,0,0])cylinder(h=8, r=15, center=true);
}

translate([70,0,0])midbracket();
endbracket();

