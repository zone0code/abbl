use <bitbeam-beam.scad>
// Mini
//beam_width     = 4;
//hole_diameter  = 2.2;

// Standard
beam_width     = 8;
hole_diameter  = 5.1;
post_diameter = 4.8;

hole_radius = hole_diameter/2;
post_radius = post_diameter/2;

switch_size = 14;

switch_height = 12;

wiring_hole = 5.2;

fitting_width = 2*beam_width;

module mx_key() {

    difference() {
        union() {
            minkowski() {
                cube([fitting_width-2, fitting_width-2, beam_width], center=true);
                sphere(1, $fn=30);
            }

            translate([beam_width/2, 0, 0]) rotate([90,0,0]) split_beam();
            translate([-beam_width/2, 0, 0]) rotate([90,0,0]) split_beam();

        }
        cube([switch_size, switch_size, beam_width + 4], center=true);
        //rotate([0,90,0]) cylinder(h=2*switch_size, r=wiring_hole/2, center=true, $fn=30);
    }
}

module mx_spacer() {
    rotate([90,0,0])
    difference() {
        union() {
            minkowski() {
                union() {
                    cylinder(h=fitting_width-2, r=beam_width/2-1, center=true, $fn=30);
                    translate([0,beam_width/4-0.5,0]) cube([beam_width-2, beam_width/2-1, fitting_width-2], center=true);
                }
                sphere(1,$fn=30);
            }
            split_beam();
        }
        cylinder(h = fitting_width + beam_width +1, r = 1, center = true, $fn=30);
    }

}

module mx_hollow_spacer() {
    rotate([90,0,0])
    difference() {
        minkowski() {
            union() {
                    cylinder(h=fitting_width-2, r=beam_width/2-1, center=true, $fn=30);
                    translate([0,beam_width/4-0.5,0]) cube([beam_width-2, beam_width/2-1, fitting_width-2], center=true);
                }
            sphere(1, $fn=30);
        }
        cylinder(h = fitting_width + beam_width+1, r = hole_radius, center = true, $fn=30);
    }
    
}

module split_beam() {
    difference(){
        union() {
            translate([0,0,-(fitting_width + beam_width)/2 +0.5]) cylinder(1, post_radius-1, post_radius, center=true, $fn=30);
            translate([0,0,(fitting_width + beam_width)/2 -0.5]) cylinder(1, post_radius, post_radius-1, center=true, $fn=30);
            cylinder(h = fitting_width + beam_width - 2, r = post_radius, center = true, $fn=30);
        }
        cube([1, post_diameter, 3.5*beam_width], center = true);
        cylinder(h = 3.5 * beam_width+1, r = 1.5, center = true, $fn=30);
    }

}

/*rounded_beam(3);
mx_hollow_spacer();
translate([0,0,1.75*beam_width-0.001])rotate([0,0,180]) rounded_beam(5);
*/

mx_key();
//translate ([15,0,0]) mx_spacer();
//translate([30,0,0]) mx_hollow_spacer();