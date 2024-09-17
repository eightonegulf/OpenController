module RepeatXY(repeatX, repeatY, size, center){
    offsetX = center ? -repeatX * size / 2 : 0;
    offsetY = center ? -repeatY * size / 2 : 0;
    
    translate([offsetX, offsetY])
    for(y = [0 : 1 : repeatY - 1])
        for(x = [0 : 1 : repeatX - 1]){
            translate([x * size, y * size])
            children();
        }
}

module Header256Single(){
    translate([1.27,1.27]){
        color("silver")
            translate([0,0,-3])
                linear_extrude(11.54)
                    square(0.64, center=true);  
      
        color("DarkSlateGray")
            linear_extrude(2.54)
                square(2.56, center=true);
    }
}

module Socket256Single(){
    translate([1.27,1.27]){
        color("silver")
            translate([0,0,-3])
                linear_extrude(3)
                    square(0.64, center=true);  
      
        color("DarkSlateGray")
            linear_extrude(8)
                difference(){
                    square(2.56, center=true);
                    square(1.54, center=true);                
                }
    }
}

module Header127Single(){
    scale(0.5)
        Header256Single();
}

module Socket127Single(){
    scale(0.5)
        Socket256Single();    
}

module Header256(rows, pins, center){
    RepeatXY(pins, rows, 2.56, center)
        Header256Single();
}

module Socket256(rows, pins, center){
    RepeatXY(pins, rows, 2.56, center)
        Socket256Single();
}

module Header127(rows, pins, center){
    RepeatXY(pins, rows, 1.27, center)
        Header127Single();
}

module Socket127(rows, pins, center){
    RepeatXY(pins, rows, 1.27, center)
        Socket127Single();
}

module ConnectorPowerboardBolt(){
    color("DarkSlateGray")
    translate([ 6.604, 0.635])
        cylinder(d=2.1,5, $fn=20);
}

module ConnectorPowerboardBolts(){
    ConnectorPowerboardBolt();
    mirror([1,0])ConnectorPowerboardBolt();
}

module ConnectorPowerboard(){
    Socket127(2,7, true);
    ConnectorPowerboardBolts();
}

module ConnectorPowerboardConsumer(){
    Header127(2,7, true);
    ConnectorPowerboardBolts();
}


module ConnectorPeripheralBolt(){
    color("DarkSlateGray")
    translate([0, -4.445])
        cylinder(d=2.1,5, $fn=20);
}

module ConnectorPeripheralMaster(){
    Socket127(4,2, true);
    
    ConnectorPeripheralBolt();
}

module ConnectorPeripheralSlave(){
    Header127(4,2, true);
    
    ConnectorPeripheralBolt();
}


module ConnectorPeripheralMasterAngled(){
    translate([-8/2,0,1.27])
    rotate([0,90,0])
    Socket127(4,2, true);
    
    translate([-2.25,-5])cylinder(d=2,50,center=true);
    translate([-2.25, 5])cylinder(d=2,50,center=true);
}