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