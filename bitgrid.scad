width=2;
height=16;

box=8;
hole=5;

module line(start, end, thickness = .2) {
    hull() {
        translate(start) circle(thickness);
        translate(end) circle(thickness);
    }
}

module grid(width=width, height=height){
    for(x=[box/2:box:width*box]) {
        for(y=[box/2:box:height*box]) {
            translate([x,y,0]) color("#ff0000") circle(hole/2,$fn=30);
        }
    }
    
}

module lines(width=width, height=height) {
    for(x=[0:box:width*box]) {
        line([x,0,0], [x,box*height,0]);
    }
    for(y=[0:box:height*box]) {
        line([0,y,0], [box*width,y,0]);
    }
}

module labels(height=height) {
       for(y=[0:box:(height-1)*box]) {
        translate([width*box+2,y+1.5,0])text(str(y/box+1),size=5);
           
    }
}

module plate(width=width, height=height, border=0) {
    color("#ccccff") difference() {
      offset(r=border) square([width*box, height*box]);
      grid(width, height);
    }
}

module ruler(width=width, height=height, rounding=0.75) {
    color("#ccccff") offset(r=rounding,$fn=30) offset(r=-rounding,$fn=30)difference() {
      square([width*box + 12, height*box]);
      grid(width, height);
        for(y=[0:box:(height-1)*box]) {
        translate([hole/4,y+box/2,0])square(hole, center=true);
        }
    }
}
ruler();
lines();
labels();


