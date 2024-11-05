
// Mini
//beam_width     = 4;
//hole_diameter  = 2.2;

// Standard
beam_width     = 8;
hole_diameter  = 5.1;
post_diameter = 4.7;

hole_radius = hole_diameter/2;
post_radius = post_diameter/2;

switch_size = 14;

switch_height = 12;

wiring_hole = 5.2;

difference() {
    union() {
        minkowski() {
            cube([2.5*beam_width-2, 2.5*beam_width-2, switch_height + 1], center=true);
            sphere(1, $fn=30);
        }

        translate([beam_width/2, 0, 0]) rotate([90,0,0]) cylinder(h = switch_size + 2*beam_width, r = post_radius, center = true, $fn=30);
        translate([-beam_width/2, 0, 0]) rotate([90,0,0]) cylinder(h = switch_size + 2*beam_width, r = post_radius, center = true, $fn=30);

    }
    translate([0,0,1.5]) cube([switch_size, switch_size, switch_height], center=true);
    rotate([0,90,0]) cylinder(h=2*switch_size, r=wiring_hole/2, center=true, $fn=30);
}