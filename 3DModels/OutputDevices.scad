include <Connectors.scad>;

module TFTDisplayScreen(){
    width = 25.0;
    length = 30.0;
    translate([-width/2,-1.8])
    color("blue")
        square([width,length]);
}

module TFTDisplay(){
    width = 27.7;
    length = 39.22;
    translate([-width/2,-1.8])
    color("darkred")
        square([width,length]);
    
    rotate([180,0,0])
        Socket256(1,7,true);
    
    translate([0,5,1])
        TFTDisplayScreen();   
}
