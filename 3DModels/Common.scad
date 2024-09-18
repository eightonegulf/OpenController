module RoundedSquare(radius, x, y){
    hull(){
        translate([x/2-radius,y/2-radius])circle(r=radius);
        translate([-x/2+radius,y/2-radius])circle(r=radius);
        translate([-x/2+radius,-y/2+radius])circle(r=radius);
        translate([x/2-radius,-y/2+radius])circle(r=radius);
    }
}

module RoundedSquareExclRadius(radius, x, y){
    hull(){
        translate([x/2,y/2])circle(r=radius);
        translate([-x/2,y/2])circle(r=radius);
        translate([-x/2,-y/2])circle(r=radius);
        translate([x/2,-y/2])circle(r=radius);
    }
}

module RoundedCube(radius, x, y, z){
    x2 = x/2 - radius;
    y2 = y/2 - radius;
    z2 = z/2 - radius;
    
    hull(){
        translate([x2,y2,z2])sphere(radius);
        translate([x2,y2,-z2])sphere(radius);
        translate([x2,-y2,z2])sphere(radius);
        translate([x2,-y2,-z2])sphere(radius);
        translate([-x2,y2,z2])sphere(radius);
        translate([-x2,y2,-z2])sphere(radius);
        translate([-x2,-y2,z2])sphere(radius);
        translate([-x2,-y2,-z2])sphere(radius);
    }
}

module HelixSegment(radius, pitch, wireRadius, resolution, i){
    rotate(i * 360)
        translate([radius,0,pitch*i])
            rotate([90,0,0])
                linear_extrude(0.010)
                    circle(r = wireRadius);
}


module HelixPart(radius, pitch, wireRadius, resolution){
    for(i = [0:resolution:1]){
        hull(){
            HelixSegment(radius, pitch, wireRadius, resolution, i);
            HelixSegment(radius, pitch, wireRadius, resolution, i+resolution);
        }
    }
}

module Helix(radius, height, turns, wireRadius, resolution){
    pitch = height / turns;
    heightPerSegment = height / turns;
    
    for(i = [0 : 1 : turns]){
        translate([0,0,heightPerSegment * i])
            HelixPart(radius,pitch,wireRadius,resolution);
    }
}
