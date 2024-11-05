
module cutouts() {
    translate([20,125,0]) {
        square([16,8]);
        translate([0, -12,0]) square([32,8]);
        translate([0, -24,0]) square([48,8]);
        translate([0, -36,0]) square([64,8]);
        translate([0, -48,0]) square([80,8]);
        translate([0, -60,0]) square([96,8]);
        translate([0, -72,0]) square([112,8]);
        translate([0, -84,0]) square([128,8]);
        translate([0, -96,0]) square([144,8]);
        translate([0, -108,0]) square([160,8]);
    }
}

module notches() {
    for(i=[4:8:250]) {
        translate([i,0,0]) square(5, center=true);
    }
}

module base() {
    /*hull() {
        square(5);
        translate([3,180,0])circle(3);
        translate([240,3,0])circle(3);
    }*/
    
    for(i=[0:1:8]) {
        translate([0,-i*9.6,0])square([16*i,9.6]);
    }
    
}

difference() {
    base();
    //cutouts();
    notches();
}