include <Connectors.scad>;
include <Common.scad>;
include <InputDevices.scad>;
include <OutputDevices.scad>;
include <USBBoard.scad>;
include <GamecontrollerPeripheral.scad>;

MainBoardWidth = 50;
MainBoardLength = 72;
MainBoardEdgeRadius = 2.54;

MainBoardMountingHoleOffset = 3.5;
MainBoardMountingHoleDiameter = 3.0;

MainBoardMountingHoles = [
    [   -MainBoardWidth / 2 + MainBoardMountingHoleOffset, 
        MainBoardMountingHoleOffset],
    [   MainBoardWidth / 2 - MainBoardMountingHoleOffset, 
        MainBoardMountingHoleOffset],
    [   -MainBoardWidth / 2 + MainBoardMountingHoleOffset, 
        MainBoardLength - MainBoardMountingHoleOffset],
    [   MainBoardWidth / 2 - MainBoardMountingHoleOffset, 
        MainBoardLength - MainBoardMountingHoleOffset]
    ];
    
PowerboardConnector = [0,38];
MainBoardTFTDisplay = [0,27.5];

MainBoardButtons = [15,16];
MainBoardRotaryEncoder = [0,16];

PeripheralA = [-MainBoardWidth/2, 49.5];
PeripheralB = [ MainBoardWidth/2, 49.5];
PeripheralC = [ 0, 0];


module MountingHoleM2(){
    circle(d=2.1);
}

module MountingHoleM3(){
    circle(d=MainBoardMountingHoleDiameter);
}

module MainBoardMountingHoles(){
    for(c = MainBoardMountingHoles){
        translate(c)
            MountingHole();   
    }
}

module MainBoardPCBShape(){ 
    
    difference(){ 
        translate([0,MainBoardLength/2])
            RoundedSquare(
                MainBoardEdgeRadius,
                MainBoardWidth,
                MainBoardLength);  
        
        USBBoardMountingHoles();
        MainBoardMountingHoles();
    }
}

module MainBoardComponentsBottom(){ 
}

module MainBoardComponentsTop(){ 
    
    translate(PeripheralA)
        rotate([0,0,180])
            ConnectorPeripheralMasterAngled();
    
    translate(PeripheralB)
        rotate([0,0,0])
            ConnectorPeripheralMasterAngled();
    
    translate(PeripheralC)
        rotate([0,0,-90])
            ConnectorPeripheralMasterAngled();
    
    translate(MainBoardButtons)
        Button6mm();
    mirror([1,0])
        translate(MainBoardButtons)
            Button6mm();
        
    translate(MainBoardRotaryEncoder)
        RotaryEncoder();
    
    
    translate(MainBoardTFTDisplay)
        Header256(1,7, true);
    
    translate(MainBoardTFTDisplay)
        translate([0,0,11])
            TFTDisplay();
            
            
    translate(PowerboardConnector)
        rotate([0,0,0])
            ConnectorPowerboardConsumer();    
}

module OtherBoards(){
    translate([0,0,1.6])
    mirror([0,0,1])
    translate(PowerboardConnector)
        translate([0,0,-5.56])
            USBBoardComplete();
    
    /*
    translate([0,0,-5.56])
        translate(PeripheralA)
            GamecontrollerPeripheral();
    
    mirror([1,0,0])
    translate([0,0,-5.56])
        translate(PeripheralA)
            GamecontrollerPeripheral();
    */
}

module MainBoardComplete(){
    
    linear_extrude(1.6)
    MainBoardPCBShape();
    translate([0,0,1.6])
    MainBoardComponentsTop();
    MainBoardComponentsBottom();
    
    OtherBoards();
}

MainBoardComplete();
