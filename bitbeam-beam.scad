/*** ABBL - Another Bit Beam Library
ABBL-beams contains a library of square and rounded end
***/
// Based on Bitbeam Project home: http://bitbeam.org

// Each bitbeam is 8mm inches wide. 
// Center of each hole is 8mm apart from each other
// Holes are 5.1 mm in diameter.

beam_width     = 8;
hole_diameter  = 5.1;

hole_radius    = hole_diameter / 2;


module beam(number_of_holes, x=true, y=false, z=false) {

    beam_length = number_of_holes * beam_width;
    translate([(number_of_holes-1)*beam_width,0,0]) {
        rotate([0,0,180]) {
            difference() {
                translate([-beam_width/2, -beam_width/2,  -beam_width/2]) {
                    // Draw the beam...
                    translate([0.5,0.5,0.5]) minkowski() {
                        cube([beam_length-1,beam_width-1,beam_width-1]);
                        sphere(0.5, $fn=20);
                    }
                }
                cut_holes(number_of_holes, x, y, z);
            }
        }
        children();
    }
}

module cut_holes(number_of_holes, x=true, y=false, z=false) {
    beam_length = number_of_holes * beam_width;
    translate([-beam_width/2, -beam_width/2,  -beam_width/2]) {
        if(x) {
            for (x=[beam_width/2 : beam_width : beam_length]) {
                translate([x,beam_width/2,-2])
                cylinder(r=hole_radius, h=12, $fn=30);
            }
        }
        if(y) {
            for (x=[beam_width/2 : beam_width : beam_length]) {
                rotate([90,0,0])
                translate([x,beam_width/2,-10])
                cylinder(r=hole_radius, h=12, $fn=30);
            }
        }
        if(z) {

            // Optional through-hole
            rotate([0,90,0])
            translate([-4,beam_width/2,-2])
            cylinder(r=hole_radius, h=number_of_holes*beam_width+4, $fn=30);
        }
    }
}

module rounded_beam(number_of_holes, x=true, y=false, z=false) {
    beam_length = number_of_holes * beam_width;
    translate([(number_of_holes-1)*beam_width,0,0]){ 
        rotate([0,0,180]) {
            difference() {
                translate([-beam_width/2, -beam_width/2, -beam_width/2]) {
                    translate([0.5,0.5,0.5]) minkowski() {
                        union() {
                            translate([(beam_width-1)/2, 0, 0]) cube([beam_length-beam_width,beam_width-1,beam_width-1]);
                            translate([(beam_width-1)/2, (beam_width-1)/2, 0]) cylinder(beam_width-1, (beam_width-1)/2, (beam_width-1)/2, $fn=30);
                            translate([beam_length - 0.75 - (beam_width)/2, (beam_width-1)/2, 0]) cylinder(beam_width-1, (beam_width-1)/2, (beam_width-1)/2, $fn=30);
                        }
                        sphere(0.5, $fn=20);
                    }
                }
                cut_holes(number_of_holes, x, y, z);
            }
            
        }
        children();
    }
        
}


module angle(number_of_holes, angle) {
    translate([(number_of_holes-1)*beam_width,0,0])rotate([0,0,angle]) {
        rotate([0,0,180 - angle]) rounded_beam(number_of_holes);
        children();
    }
 
}

module corner(number_of_holes) {
    
    rotate([0,-90,0]) beam(number_of_holes, true, true, false);
    beam(number_of_holes, true, true, false);
    rotate([0,0,90]) beam(number_of_holes, true, true, false);
}

module beam_cube(number_of_holes) {
    beam_length = (number_of_holes-1) * beam_width;
    corner(number_of_holes);
    translate([beam_length, beam_length,0]) rotate([0,0,180]) corner(number_of_holes);
    translate([beam_length,0,beam_length])rotate([0,90,90])corner(number_of_holes);
    translate([0,beam_length,beam_length])rotate([0,90, -90])corner(number_of_holes);
        
}

module curve_beam(radius, angle) {
    increment = 2* asin(beam_width/(2*radius));
    translate([beam_width/2,-radius,0])
    rotate([0,0,-floor(angle/increment)*increment])
    {
        
        for(i=[0:increment:angle]) {
            rotate([0,0,i]) translate([-beam_width/2,radius,0]) rounded_beam(2);
        }
        translate([beam_width/2,radius,0]) children();
    }
}

module circle_beam(number_of_holes) {
    increment = 360/number_of_holes;
    radius = beam_width/(2*sin(increment/2));
    
    for(i=[0:increment:360]) {
        rotate([0,0,i]) translate([-beam_width/2,radius,0]) rounded_beam(2);
    }
}

//translate([-beam_width/2,0,0])rounded_beam(2);
//curve_beam(50, 120);
/*
translate([-2*beam_width,0,0]){
    curve_beam(80, 60);
    rounded_beam(3);
}
*/
/*
difference() {
    union() {
    rotate([0,90,90]) translate([-beam_width/2,0,0]) rounded_beam(2);
    beam(4);
    }
    rotate([0,90,90]) translate([-beam_width/2,0,0]) cut_holes(2);
}
*/

//circle_beam(16);
