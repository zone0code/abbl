//wide board
kbw=200; //keypad width
kw=192; //key width
//narrow macro pad
//kbw=105; //keypad width
//kw=96; //key width

kbl=86; //keypad length
kbh=10; //keypad height
kbr=1  ; //keypad rounding
kl=79; //key length
kh=13; //key height
ucw = 23; //microcontroller width
ucl = 45; //micro length
uch = 5; //micro height
uci = 40; //micro inset

tol=0.2;//tolerance

angle=7;//keypad angle

cut=4; //cable cutout size
ccw=9;
cci=47;

module rounded(radius) {
    offset(r=radius) offset(delta=-radius, chamfer=false) children();
}

module chamfer(radius) {
    offset(delta=radius, chamfer=true) offset(delta=-radius, chamfer=false) children();
}

module keypad() 
{
    //keypad base
    linear_extrude(kbh) square([kbw, kbl], center=true);
     
    
    //keypad keys
    translate([0,0,kbh])
    linear_extrude(kh)
    square([kw, kl], center=true);
    
    //microcontroller 
    translate([uci - kbw/2 +ucw/2,(kbl-ucl)/2,-uch]) 
    linear_extrude(uch)
    square([ucw, ucl], center=true);
}

module base()
{
    minkowski() {
        cube([kbw-3, kbl-3, 10], center=true);
        sphere(6, $fn=100);
    }
}

module base2proj(center=true) {
   
        square([kbw+5, kbl+5], center=center);
   
}

module base2()
{
    difference() {
        translate([0,0,-1]) {
            translate([0,0,7]) linear_extrude(6, scale=0.97) base2proj();
            linear_extrude(7) base2proj();
            translate([0,0,0]) rotate([180,0,0]) linear_extrude(kbh*2-5) base2proj();
        }
        translate([0,0,-(kbh+7)]) rotate([-angle,0,0]) cube([kbw*2, kbl*2, kbh*2], center=true);
    }
    
}

module rotate_base2(mod)
{
    difference() {
        translate([0,0,-5]) {
            translate([0,0,10]) linear_extrude(6, scale=.95) base2proj();
            linear_extrude(10) base2proj();
            translate([0,0,0]) rotate([180,0,0]) linear_extrude(kbh*2-5, scale=.9) base2proj();
        }
        translate([0,0,-(kbh+10)]) rotate([0,mod,0]) cube([kbw*2, kbl*2, kbh*2], center=true);
    }
    
}

module cablecut(size) {
    translate([0,kbl/2+10,0])
    rotate([90,0,0]) 
    linear_extrude(kbl+20) {
        hull() {
            translate([-(kbw-20)/2,0,0]) circle(size, $fn=50);
            translate([(kbw-20)/2,0,0]) circle(size, $fn=50);
            }
    }
    translate([-(kbw/2+10),0,0])
    rotate([0,90,0]) 
    linear_extrude(kbw+20) {
        hull() {
            translate([0,-(kbl-20)/2,0]) circle(size, $fn=50);
            translate([0,(kbl-20)/2,0]) circle(size, $fn=50);
            }
    }
}

module cablecut2(size) {
    translate([0,kbl/2+10,0])
    rotate([90,0,0]) 
    linear_extrude(11) {
        hull() {
            translate([cci - kbw/2 +ccw,0,0]) circle(size, $fn=50);
            translate([cci - kbw/2,0,0]) circle(size, $fn=50);
            }
    }
 
    
}
module completecase() {
    translate([0,0,-5])
    difference() {
        base2();
        translate([0,0,-1]) keypad();
        translate([0,0,-4]) cablecut2(cut);
    }   
}



module bottom(cut=false) {
    difference() {
    intersection() {
        union(){
            translate([0,0,-(kbh+2)])cube([kbw*2, kbl*2, kbh*2], center=true);
            translate([0,0,-(0.75*kbh+2)]) linear_extrude(kbh) minkowski() {
                square([kbw, kbl], center=true);
                circle(kbr, $fn=20);
            }
            translate([0,0,0]) linear_extrude(1, scale=0.99) minkowski() {
                square([kbw, kbl], center=true);
                circle(kbr+0.25, $fn=20);
            }
        }
        children();
    }
    if(cut) {
    translate([0,0,-30]) linear_extrude(60){
translate([-kbw/2+3, -kbl/2+3,0]) {
    difference() {
        union() {
            for (i=[0:kbw/4:kbw-1]) {
                for (j=[0:kbl/2:kbl-1]) {
                    translate([i, j, 0]) square([kbw/4-6, kbl/2-6]);    
                }
            }
        }
        for (i=[0:kbw:kbw]) {
            
                translate([i-3, 0, 0]) circle(30,$fn=60);  
             
        
        }
       
                    }
                }
            }
        
            translate([-130,12,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([-130,20,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([-130,28,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([-130,36,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            
            translate([80,12,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([80,20,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([80,28,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            translate([80,36,-9]) rotate([0,90,0])cylinder(r=2.5, h=50, $fn=30);
            
            translate([-88,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-80,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-72,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-64,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            
            translate([-32,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-24,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-16,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([-8,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);

            translate([8,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([16,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([24,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([32,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([40,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);

            translate([64,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([72,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([80,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
            translate([88,12,-9]) rotate([0,90,90])cylinder(r=2.5, h=50, $fn=30);
        }

    }
}


module top() {
    rotate([180,0,0]) difference() {
        children();
        bottom() children();
        
    }
}

module handrest() {
    //I actually don't currently have a problem to solve here
}

//translate([-0.6*kbw,0,0])bottom(cut=true) completecase();
//translate([0.6*kbw,0,0]) top() completecase();    
//top() completecase();
//bottom(cut=true) completecase();
completecase();
//mat();
//bottom();
