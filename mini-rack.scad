use <abbl-base.scad>

//pin parameters
hdia = 2.5;
ow = 0.75;
r =1;
$fn=20;


module pin() {
    translate([0,-hdia,0]) {
        translate([-(hdia+ow)/2,0,0])
        {
            offset(r=-r) offset(r=r)
             {
                circle(hdia/2);
                translate([hdia+ow,0,0]) circle(hdia/2);
            }
            //translate([(hdia+ow)/2,5,0]) square([ow, 10], center=true);
            translate([(hdia+ow)/2,-hdia/4,0]) square([hdia+ow, hdia/2], center=true);       
        }
        wedge(1.75*hdia, 1.1*hdia, ow);
    }
}

module wedge(r , l, w) {
    difference() {
        translate([0,l/2,0]) square(l, center=true);
        translate([-(r+w/2),0,0]) circle(r, $fn=200);
        translate([(r+w/2),0,0]) circle(r, $fn=200);
    }
}


module squarerack(size, rad, pnum, high=1.5) {
    linear_extrude(high)
    difference() {
        offset(rad) offset(-rad) square(size);
        for(i = [1 : pnum]) {
            translate([i*size/(pnum+1), size,0]) pin();
            translate([i*size/(pnum+1), 0,0]) rotate([0,0,180]) pin();
            translate([0, i*size/(pnum+1), 0]) rotate([0,0,90]) pin();
            translate([size, i*size/(pnum+1), 0]) rotate([0,0,-90]) pin();
        }
  
    }
}

module rectrack(lsize, wsize, rad, lpnum, wpnum, high=1.5) {
    linear_extrude(high)
    difference() {
        offset(rad) offset(-rad) square([lsize,wsize]);
        for(i = [1 : lpnum]) {
            translate([i*lsize/(lpnum+1), wsize,0]) pin();
            translate([i*lsize/(lpnum+1), 0,0]) rotate([0,0,180]) pin();
        }
        for(i = [1 : wpnum]) {
           translate([0, i*wsize/(wpnum+1), 0]) rotate([0,0,90]) pin();
           translate([lsize, i*wsize/(wpnum+1), 0]) rotate([0,0,-90]) pin();
        }
  
    }
}

module stickitrack(){
    difference() {
        squarerack(100, 15, 5, 4);
        translate([10,10,1.5]) cube(80);
    }
}

module cardrack(hole=true){
    difference() {
        union() {
            intersection() {
                //base rack
                rectrack(110,70, 12, 5, 4);
                //relief overlay
                translate([0,0,1.5]) rotate([90,0,90]) translate([-2.5,0,0]) linear_extrude(110) {
                    offset(0.5) offset(-0.5) difference(){
                        union() {
                            translate([5,0,0]) circle(2.5);
                            translate([70,0,0]) circle(2.5);
                        }
                        translate([5,1.5,0]) circle(1);
                        translate([70,1.5,0]) circle(1);    
                    }
                    translate([5,-65,0]) square(65);
                }
            }
            //keyring surround
            minkowski() { translate([5,5,1]) cylinder(1.8, r=4); sphere(1);}
            minkowski() { translate([5,65,1]) cylinder(1.8, r=4); sphere(1);}
            minkowski() { translate([105,5,1]) cylinder(1.8, r=4); sphere(1);}
            minkowski() { translate([105,65,1]) cylinder(1.8, r=4); sphere(1);}
          
        }
        //keyring hole
        translate([5,5,0]) cylinder(10, r=3);
        translate([5,65,0]) cylinder(10, r=3);
        translate([105,5,0]) cylinder(10, r=3);
        translate([105,65,0]) cylinder(10, r=3);
        if(hole) {
            //thumb slot
            translate([30,35,0])linear_extrude(10) hull() {
                circle(10);
                translate([50,0,0]) circle(10);
            }
            //lanyard slot
            translate([45,7,0])linear_extrude(10) hull() {
                circle(2);
                translate([20,0,0]) circle(4);
            }
        }
        
    }
}

module lumpyrack() {
    cardrack(false);
    
    translate([28,66,0.5])rotate([90,0,0])linear_extrude(62) for(i = [0:18:54]) {
        translate([i, 0, 0]) scale([5.6,1,1])difference() {
            offset(0.5) offset(-0.5) difference() {
                circle(2.5);
                translate([0,2.5,0]) circle(1.5);
                
            }
            translate([0,-2.5,0]) square(5, center=true);    
        } 
    }   
}

module cleat() {
    difference() { 
        minkowski() { 
            intersection(){
                union() {
                    cylinder(3,1,3);
                    translate([0,0,3])cylinder(1.5,3,5);
                }
                translate([-10,0,-8]) sphere(15);
            } 
            sphere(0.5);
        } 
        translate([0,0,-2.5]) cube(5, center=true);}
}

//cardrack();

module bitbeam_rack() {
    difference() {
        rectrack(110,72, 12, 7, 4);
        translate([27,4,0]) rounded_beam(8, false);
        //translate([27,68,0]) rounded_beam(8, false);
        //thumb slot
        translate([30,35,0])linear_extrude(10) hull() {
            circle(12);
            translate([50,0,0]) circle(12);
        }
    } 
    translate([5,21,0]) cleat();
    translate([5,35,0]) cleat();
    translate([5,49,0]) cleat();
    translate([105,21,0]) rotate([0,0,180]) cleat();
    translate([105,35,0]) rotate([0,0,180]) cleat();
    translate([105,49,0]) rotate([0,0,180]) cleat();
    translate([27,4,2]) scale([1,1,0.5])rounded_beam(8);
    //translate([27,68,2]) scale([1,1,0.5])rounded_beam(8);
    translate([27,68,0]) studs(8);
}

module bitbeam_rack2() {
    difference() {
        rectrack(112,72, 12, 0, 4);
        translate([4,4,0]) rounded_beam(14, false);
        translate([4,68,0]) rounded_beam(2, false);
        translate([100,68,0]) rounded_beam(2, false);
        //thumb slot
        translate([30,35,0])linear_extrude(10) hull() {
            circle(12);
            translate([50,0,0]) circle(12);
        }
        

    } 
    translate([5,21,0]) cleat();
    translate([5,35,0]) cleat();
    translate([5,49,0]) cleat();
    translate([107,21,0]) rotate([0,0,180]) cleat();
    translate([107,35,0]) rotate([0,0,180]) cleat();
    translate([107,49,0]) rotate([0,0,180]) cleat();
    difference() {
        translate([4,4,1]) scale([1,1,0.25])rounded_beam(14);
        //lanyard
        translate([44,4,-4])linear_extrude(8) hull() {
            circle(2.5);
            translate([24,0,0]) circle(2.5);
        }
    }
    translate([4,68,1]) scale([1,1,0.25])rounded_beam(2);
    translate([100,68,1]) scale([1,1,0.25])rounded_beam(2);
    translate([28,68,0]) studs(8);
   
}

module bitbeam_rack3() {
    difference() {
        rectrack(112,72, 12, 0, 4);
        translate([4,4,0]) rounded_beam(14, false);
        translate([4,68,0]) rounded_beam(2, false);
        translate([100,68,0]) rounded_beam(2, false);
        //thumb slot
        translate([30,35,0])linear_extrude(10) hull() {
            circle(10);
            translate([50,0,0]) circle(10);
        }
        

    } 
    translate([5,21,0]) cleat();
    translate([5,35,0]) cleat();
    translate([5,49,0]) cleat();
    translate([107,21,0]) rotate([0,0,180]) cleat();
    translate([107,35,0]) rotate([0,0,180]) cleat();
    translate([107,49,0]) rotate([0,0,180]) cleat();
    difference() {
        translate([4,4,1]) scale([1,1,0.25])rounded_beam(14);
        //lanyard
        translate([52,4,-4])linear_extrude(8) hull() {
            circle(2.5);
            translate([8,0,0]) circle(2.5);
        }
    }
    translate([4,68,1]) scale([1,1,0.25])rounded_beam(2);
    translate([100,68,1]) scale([1,1,0.25])rounded_beam(2);
    translate([28,68,0]) studs(8);
   
}

bitbeam_rack3();
//rectrack(112,72, 12, 0, 4);