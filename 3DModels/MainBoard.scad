include <Connectors.scad>;
include <Common.scad>;
include <InputDevices.scad>;
include <OutputDevices.scad>;
include <USBBoard.scad>;
include <GamecontrollerPeripheral.scad>;

MainBoardMountingHoles = [
    [-16.002,29.337],
    [16.002,29.337],
    [-16.002,-28.575],
    [16.002,-28.575]];

PeripheralA = [-17.78, 11.43];
PeripheralB = [ 17.78, 11.43];
PeripheralC = [ 0, -32.385];


module MountingHole(){
    circle(d=2.1);
}

module MainBoardMountingHoles(){
    for(c = MainBoardMountingHoles){
        translate(c)
            MountingHole();   
    }
}

module MainBoardPCBShape(){ 
    width = 43.434;
    length = 70.8660;
    
    linear_extrude(1)
    difference(){ 
        translate([0,length/2 - 37.084])
            RoundedSquare(2.54,width,length);  
        
        USBBoardMountingHoles();
        MainBoardMountingHoles();
    }
}


module MainBoardComponents(){ 
    rotate([0,180,0])
        ConnectorPowerboardConsumer();
    
    translate(PeripheralA)
        rotate([180,0,0])
            ConnectorPeripheralMaster();
    
    translate(PeripheralB)
        rotate([180,0,0])
            ConnectorPeripheralMaster();
    
    translate(PeripheralC)
        rotate([180,0,-90])
            ConnectorPeripheralMaster();
    
    translate([13.97,-21.717])
        Button6mm();
    translate([-13.97,-21.717])
        Button6mm();
    
    translate([0,-21.717])
        RotaryEncoder();
    
    translate([0,-10.541,11])
        TFTDisplay();
}

module OtherBoards(){
    translate([0,0,-5.56])
        USBBoardComplete();
    
    translate([0,0,-5.56])
        translate(PeripheralA)
            GamecontrollerPeripheral();
    
    mirror([1,0,0])
    translate([0,0,-5.56])
        translate(PeripheralA)
            GamecontrollerPeripheral();
}

module MainBoardComplete(){
    MainBoardPCBShape();
    MainBoardComponents();
    
    OtherBoards();
}

MainBoardComplete();