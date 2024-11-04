use <abbl-base.scad>
kw=10;
kh=4;

ks=14;
spc=5;
border=7;

dpth=3;

pw=208;
ph=96;

module keyplate2() {
     linear_extrude(dpth) 
    difference() {

        square([pw,ph], center=true);
        keycutout();
        
    }
}

module keyplate() {
     linear_extrude(dpth) 
    difference() {

        square([2*border+kw*ks+spc*(kw-1), 2*border+kh*ks+spc*(kh-1)], center=true);
        keycutout();
        
    }
}

module dollarmites() {
     linear_extrude(dpth) 
    difference() {

        union() {
         translate([-170/2,0,0]) resize([50,95,0]) circle(25);   
         translate([170/2,0,0]) resize([50,95,0]) circle(25); 
         square([170,95], center =true)   ;
        }
        keycutout();
        
    }
    
}

module keycutout() {
translate([-(kw*ks+spc*(kw-1))/2,-(kh*ks+spc*(kh-1))/2 , 0]) union() {
            for(i=[0:1:kw-1]) {
                for(j=[0:1:kh-1]) {
                    if(j!=0||i!=5&&i!=6) {
                        translate([i*(ks+spc), j*(ks+spc),0])square(ks);
                    }
                    if(j==0&&i==5){
                        translate([(i+ 0.5)*(ks+spc), j*(ks+spc),0])square(ks);
                    }
                }
            }
        }
}

module stabcutout() {
    translate([9.5,0,0]) {
        translate([-8.2,0,0]) stabhole();
        translate([15.5,0,0]) stabhole();
        square(14);
        translate([-9.5,6.6,0]) square([33,3]);
    }
}

module stabhole() {
    square([6.7, 12.3]);
    translate([1.85,-1.2,0]) square(3);
}



//dollarmites();
keyplate2();
translate([-98,-44,-4]) rotate([90,0,90])scale([1,1,0.5]) beam(12);