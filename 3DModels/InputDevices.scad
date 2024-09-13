module Button6mm(){
    color("DarkSlateGray")
        linear_extrude(3.5)
            square(6, center=true);
    
    color("silver")
        translate([0,0,3.5])
            linear_extrude(0.1)
                square(6, center=true);
    
    color("black")
        cylinder(d=4,6);
    
    
    color("black")
        for(i = [0 : 90 : 360])
            rotate(i)
                translate([2,2])
                    cylinder(d=1,3.7);
}

module JoystickPot(){
    color("green")
        linear_extrude(12)
            square([9.5,2],center=true);
}

module JoystickHead(){
    difference(){
        sphere(d=25);
        mirror([0,0,1])
            linear_extrude(100)
            square(100,center=true);
    }
    
    translate([0,0,13])
    cylinder(d=20,3);
}

module RotaryEncoder(){
    color("DarkSlateGray")
        linear_extrude(6.5)
            square(11.7, center=true);
    
    color("silver")
        cylinder(d=5,15);
}

module Joystick(){
    translate([0,0,10])
    JoystickHead();
    
    
    translate([0,8.76])
        JoystickPot();
    rotate(90)
    translate([0,8.76])
        JoystickPot();
    
    linear_extrude(12)
        square(16,center=true);
    
    translate([7.9,0])
        Button6mm();
}