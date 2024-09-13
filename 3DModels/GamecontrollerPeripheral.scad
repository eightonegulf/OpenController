include <Connectors.scad>;
include <Common.scad>;
include <InputDevices.scad>;




module GamecontrollerPeripheral(){
    rotate([0,0,180])ConnectorPeripheralSlave();



    translate([-25,-30])rotate([0,0,180])Joystick();
    
    translate([-50,0])DPad();
}