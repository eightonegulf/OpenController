include <Connectors.scad>;
include <Common.scad>;
include <InputDevices.scad>;




module GamecontrollerPeripheral(){
    rotate([0,0,180])ConnectorPeripheralSlave();



    translate([-50,0])rotate([0,0,180])Joystick();
}
