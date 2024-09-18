include <MainBoard.scad>;
include <USBBoard.scad>;
include <Common.scad>;

//$fn = 50;

M3NutDia = 5.5;
M3BoltHexHeadDia = 5.8;
M3BoltHexHeadHeight = 3;
M3BoltDia = 3;
M3BoltDiaSelfTap = 2.9;



M2NutDia = 4.5;
M2BoltHexHeadDia = 5.8;
M2BoltHexHeadHeight = 2;
M2BoltDia = 2;
M2BoltDiaSelfTap = 1.9;

MainBoardWidth = 50;
MainBoardLength = 72;
MainBoardMargin = 0.5;

BorderSizeSide = 5;
BorderSizeBottom = 5;
BorderSizeTop = 2;
BorderRadius = 4;

CaseTopThickness = 3;
CaseBottomThickness = 3;

CaseWidth = MainBoardWidth + BorderSizeSide * 2;
CaseLength = MainBoardLength + BorderSizeBottom + BorderSizeTop;

DisplayPosition = [0,47];
DisplayRiserHeight = 1;
DisplayMountHolesDiameter = M3BoltDiaSelfTap;

module MainPCBShapeMargin(){
    $fn=20;
    minkowski(){
        hull()
            MainBoardPCBShape();
        circle(MainBoardMargin);
    }
}

module CaseBaseShape(){
    translate([0,CaseLength/2 - BorderSizeBottom])
        RoundedSquare(BorderRadius,CaseWidth,CaseLength);
}

module CaseOutline(){
    difference(){
        CaseBaseShape();            
        MainPCBShapeMargin();
    }
}

module CaseBaseShape3D(){
    translate([0,CaseLength/2 - BorderSizeBottom,-100])
        RoundedCube(BorderRadius,CaseWidth,CaseLength,200);
}

{  //Display
    module DisplayPanelHole(){
        width = 23.0;
        length = 23.0;
        
        angleStartHeight = 1;
        angleFactor = 3;
        
        angleHeight = 10;
        
        translate(TFTDisplayRelativePosition){
            linear_extrude(angleStartHeight)
                square([width,length],center=true);
            
            translate([0,0,angleStartHeight])
                hull(){            
                    linear_extrude(0.01)
                        square([width,length],center=true);
                    
                    translate([0,0,angleHeight])
                        linear_extrude(0.01)
                            square([
                                width + 
                                angleHeight * angleFactor,
                                length + 
                                angleHeight * angleFactor],center=true);
                }
        }
    }
    
    module DisplayMountHoles(){
        translate([0,0,-DisplayRiserHeight])
        for(i = TFTDisplayMountHolePositions)
            translate(i)
                cylinder(
                    d=DisplayMountHolesDiameter,
                    CaseTopThickness + DisplayRiserHeight - 1,
                    $fn = 20); 
    }
    
    module DisplayHoles(){      

        DisplayMountHoles();
        DisplayPanelHole();
    }
    
    module DisplayRisers(){        
        translate([0,0,-DisplayRiserHeight])
            for(i = TFTDisplayMountHolePositions)
                translate(i)
                    cylinder(
                        d=5,
                        DisplayRiserHeight,
                        $fn = 20); 
    }
}




/*
translate([0,-10,5])
rotate([90,0,90])
cylinder(d=16,35, center=true);
*/

module CaseBoltHeads(){
    translate([0,0,CaseTopThickness - M3BoltHexHeadHeight])
        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(
                    d=M3BoltHexHeadDia,
                    M3BoltHexHeadHeight+1,
                    $fn = 20);   
        }
}
module CaseBolts(){
    translate([0,0,CaseTopThickness - M3BoltHexHeadHeight])
        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(
                    d=M3BoltDia,
                    500,
                    center=true,
                    $fn = 20);   
        }
}


module CaseTop(){
    render()
    difference(){
        union(){
            intersection(){
                linear_extrude(CaseTopThickness)
                    render()
                        difference(){
                            CaseBaseShape();
                            translate(MainBoardRotaryEncoder)circle(d=5.5, $fn=20);
                            translate(MainBoardButtons)circle(d=5, $fn=20);
                            mirror([1,0,0])
                                translate(MainBoardButtons)circle(d=5, $fn=20);
                        }   
                       
                translate([0,0, CaseTopThickness])
                    CaseBaseShape3D();
            }
            
            translate(MainBoardTFTDisplay)
                DisplayRisers();
        }
        
        translate(MainBoardTFTDisplay)
            DisplayHoles();
        

        CaseBoltHeads(); 
        CaseBolts();
        
        translate(MainBoardRGBLeds)
            LightPipe();
        mirror([1,0,0])
            translate(MainBoardRGBLeds)
                LightPipe();
    }    
    

}

    USBBoardLipHeight = 6.2;
    USBBoardLipLength = 8.5;
    MainBoardLipHeight = 12.9 + 1.6;

module BoardMountingLips(){    
    mirror([0,0,1]){
        linear_extrude(USBBoardLipHeight-2){
            intersection(){
                translate([0,CaseLength - BorderSizeBottom - USBBoardLipLength/2])
                    square([CaseWidth,USBBoardLipLength],center=true);           
                    CaseBaseShape();
            }
        }    
        
        for(i = USBBoardMountingHoles){
            translate(PowerboardConnector  + i)
                cylinder(d=5,USBBoardLipHeight);   
        }


        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(d=6,MainBoardLipHeight);   
        }
    }
}

module USBPortHoleFlat(){
    hull(){
        translate([3,0,0])
            circle(d=3);
        translate([-3,0,0])
            circle(d=3);
    }
}

module USBPortHole(){
    $fn = 25;
    rotate([-90,0,0]){
        linear_extrude(1)
            USBPortHoleFlat();
        
        translate([0,0,1])
            linear_extrude(1)
                scale(1.5)
                    USBPortHoleFlat();
        
        hull(){
            translate([0,0,1.5])
                linear_extrude(0.1)
                    scale(1.5)
                        USBPortHoleFlat();
            translate([0,0,5])
                linear_extrude(1)
                    scale(5)
                        USBPortHoleFlat();        
        }
    }
}

module CaseMid(){
    render()
    difference(){
        intersection(){
            union(){
                BoardMountingLips();
                mirror([0,0,1])
                linear_extrude(MainBoardLipHeight)
                    CaseOutline();                                     
            }

            translate([0,0,CaseTopThickness])
                CaseBaseShape3D();
        }
        
        CaseBolts();
            
        translate([0,0,-MainBoardLipHeight])
            linear_extrude(1.6)
                MainPCBShapeMargin();
        
        mirror([0,0,1]){
            for(i = USBBoardMountingHoles){
                translate(PowerboardConnector  + i)
                    cylinder(d=M2BoltDiaSelfTap,USBBoardLipHeight + 1, $fn=20);  
                
                translate([0,0,USBBoardLipHeight])
                translate(PowerboardConnector  + i)
                    linear_extrude(100)
                    square([5,10],center=true);
            }            
        }
        
        translate([0,72,-9])USBPortHole();
    }   
}

module LightPipeCutoutTrace(){
    $fn= 20;
    width = 2;
    radius = 4;
    length = 5;
    
    translate([3,0]){
        translate([-radius,-radius])
        intersection(){
            difference(){
                circle(r=radius+width/2);
                circle(r=radius-width/2);
            }
            square(1000);
        }
        
        hull(){
            translate([-radius,0])
                circle(d=width);
            translate([-length,0])
                circle(d=width);
        }
        
        rotate(90)
        hull(){
            translate([-radius,0])
                circle(d=width);
            translate([-length,0])
                circle(d=width);
        }
    }
    
}

module LightPipe(){    
    linear_extrude(5)
        LightPipeCutoutTrace();
    
    linear_extrude(1)
        minkowski(){
            LightPipeCutoutTrace();
            circle(d=2);
        }
}

module CaseBottomLid(){
    MainPCBGap = 2;
    
    render()
    difference(){
        intersection(){
            union(){
                linear_extrude(MainPCBGap + CaseBottomThickness)
                    CaseOutline();
                
                linear_extrude(CaseBottomThickness)
                    CaseBaseShape();
                
                translate([0,0,CaseBottomThickness]){
                    for(i = MainBoardMountingHoles){
                        translate(i)
                            cylinder(d=6,MainPCBGap);   
                    }
                    
                    translate(MainBoardRotaryEncoder)
                        cylinder(d=6,MainPCBGap);
                    
                    translate(MainBoardButtons)
                        cylinder(d=4,MainPCBGap);
                    mirror([1,0,0])
                        translate(MainBoardButtons)
                            cylinder(d=4,MainPCBGap);
                }               
            }
            
            mirror([0,0,1])
                CaseBaseShape3D();
        }
        
        CaseBolts();
        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(d=M3NutDia,3,$fn=6);   
        }
    }
}

module ButtonSpring(){
    color("silver")        
        Helix(3,3,5,0.2,0.1);
}

module Button(){
    $fn = 20;
    color("darkgray"){
        render()
        difference(){
            union(){
                cylinder(d=4.5,10.5);
                cylinder(d=7,3);
            }
            
            cylinder(d=3.5,1);            
        }
    }
    
    translate([0,0,3])ButtonSpring();
}

module Case(){
    render()
    difference(){
        union(){
            CaseTop();
            CaseMid();
        }

        SidePeripheralCutout();
        mirror([1,0,0])SidePeripheralCutout();
        BottomPeripheralCutout();
    }
}


module SidePeripheralCutout(){
    translate([0,0,-1])
    mirror([0,0,1])
        translate([0,10,1.5])
            linear_extrude(12)
                square([100,50]);
}

module BottomPeripheralCutout(){
    translate([0,0,-1])
    mirror([0,0,1])
        translate([0,-5,1.5])
            linear_extrude(12)
                square([35,10],center=true);
    
}


translate([0,0,14.6])Case();
translate([0,0,-5.1])CaseBottomLid();

translate([0,0,7.8]){
    translate(MainBoardButtons)Button();
    mirror([1,0,0])translate(MainBoardButtons)Button();
}





MainBoardComplete();