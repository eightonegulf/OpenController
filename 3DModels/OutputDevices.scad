include <Connectors.scad>;

TFTDisplayMountHolePositions = [
    [ 11.4,2.50 - 1.8],
    [-11.4,2.50 - 1.8],
    
    [ 11.4,39.22 - 1.8 - 2.50],
    [-11.4,39.22 - 1.8 - 2.50],
    ];

TFTDisplayRelativePosition = [0, -1.8+6.33 + 23.4/2];

module TFTDisplayScreen(){
    width = 23.40;
    length = 23.40;
    color("blue")
        linear_extrude(1)
            square([width,length],center=true);
}

module TFTDisplayHoles(){
    for(i = TFTDisplayMountHolePositions)
        translate(i)
            cylinder(d=2,20);
}

module TFTDisplay(){
    width = 27.78;
    length = 39.22;
    color("darkred")
        linear_extrude(1)
        translate([-width/2,-1.8])
            square([width,length]);
    
    rotate([180,0,0])
        Socket256(1,7,true);
    
    translate(TFTDisplayRelativePosition)
        translate([0,0,1])
            TFTDisplayScreen();   

}