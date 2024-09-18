include <Connectors.scad>;
include <Common.scad>;

USBBoardMountingHoles = [
    [-17,-1.651],
    [17,-1.651],
    [-15,29.337],
    [15,29.337]];

module MountingHole(){
    circle(d=2.1);
}

module USBBoardMountingHoles(){
    for(c = USBBoardMountingHoles){
        translate(c)
            MountingHole();   
    }
}

module USBBoardPCBShape(){
    width = 22.86;
    length = 30.988;
    
    mirror([0,0,1])
    linear_extrude(1.2)
    difference(){
        hull(){
            translate([0,length/2 - 1.651])
                RoundedSquareExclRadius(2.54,width,length);
            
            translate([0,33.909])
                square([10.16,0.1],center=true);
        }        
        USBBoardMountingHoles();
    }    
}

module USBPort(){
    color("silver")
        linear_extrude(3.1)
            translate([-9.4/2, 0])
                square([9.4,10.5]);
}


module USBBoardComponents(){
    ConnectorPowerboard();
    translate([0,24])USBPort();
}


module USBBoardComplete(){
    color("green")USBBoardPCBShape();
    USBBoardComponents();
}