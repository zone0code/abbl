use <abbl-base.scad>
// Mini
//beam_width     = 4;
//hole_diameter  = 2.2;

// Standard
beam_width     = 8;
hole_diameter  = 5.1;
post_diameter = 4.8;

hole_radius = hole_diameter/2;
post_radius = post_diameter/2;


switch_size = 14; // the width of the switch
switch_height = 9; // the height of the switch
switch_spacing = 6; // amount of space between switches

wiring_hole = 5.2;

fitting_width = 2*beam_width;

module mx_key(size=1, render_mount=true, mid_mount=false, mount_offset=-2) {
    
    switch_length = ((size*switch_size)+((size-1)*switch_spacing));
    fitting_length = ceil(switch_length/beam_width)*beam_width;

    difference() {
        union() {
            minkowski() {
                cube([fitting_length-2, fitting_width-2, switch_height-2], center=true);
                sphere(1, $fn=30);
            }
            if(render_mount) {
                if(mid_mount){

                    translate([(beam_width)/2, 0, mount_offset]) rotate([90,0,0]) split_beam();
                    translate([-(beam_width)/2, 0, mount_offset]) rotate([90,0,0]) split_beam();
                } else {

                    translate([(fitting_length-beam_width)/2, 0, mount_offset]) rotate([90,0,0]) split_beam();
                    translate([-(fitting_length-beam_width)/2, 0, mount_offset]) rotate([90,0,0]) split_beam();
                }
            }
        }
        translate([-(switch_length-switch_size)/2,0,0]) { 
            for(i=[0:1:size-1]) {
                translate([(switch_size+switch_spacing)*i,0,0]) cube([switch_size, switch_size, switch_height + 4], center=true);
            }
        }
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

mx_key(2);
//translate ([0,30,0]) mx_spacer();
//translate([0,60,0]) mx_hollow_spacer();