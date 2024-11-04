use <abbl-base.scad>


function grid(c) = [c.x*size() + size()/2, c.y*size() + size()/2, c.z*size() + size()/2];

module gridfill(x, y) {
    translate([-size()/2, -size()/2, -size()/2])
    for(i = [0:x-1]) {
        for(j = [0:y-1]) {
            translate(grid([i,j,0])) beam(1,true,true,true); 
        }
    }
}

module studfill(x, y) {
    translate([-size()/2, -size()/2, -size()/2])
    for(i = [0:x-1]) {
        for(j = [0:y-1]) {
            translate(grid([i,j,0])) studs(1); 
        }
    }
}


translate(grid([0,0,0])) studfill(4,4);
