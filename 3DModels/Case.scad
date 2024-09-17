include <MainBoard.scad>;
include <USBBoard.scad>;
include <Common.scad>;


M3NutDia = 5.5;
M3BoltHexHeadDia = 5.8;
M3BoltHexHeadHeight = 3;
M3BoltDia = 3;



M2NutDia = 4.5;
M2BoltHexHeadDia = 5.8;
M2BoltHexHeadHeight = 2;
M2BoltDia = 2;

MainBoardWidth = 50;
MainBoardLength = 72;
MainBoardMargin = 0.5;

BorderSizeSide = 5;
BorderSizeBottom = 5;
BorderSizeTop = 2;
BorderRadius = 5;

CaseTopThickness = 3;
CaseBottomThickness = 3;

CaseWidth = MainBoardWidth + BorderSizeSide * 2;
CaseLength = MainBoardLength + BorderSizeBottom + BorderSizeTop;

DisplayPosition = [0,47];
DisplayRiserHeight = 1;
DisplayMountHolesDiameter = 3;

module MainPCBShapeMargin(){
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
                    CaseTopThickness + DisplayRiserHeight - 1); 
    }
    
    module DisplayHoles(){      

        DisplayMountHoles();
        DisplayPanelHole();
    }
    
    module DisplayRisers(){        
        translate([0,0,-DisplayRiserHeight])
            for(i = TFTDisplayMountHolePositions)
                translate(i)
                    cylinder(d=5,DisplayRiserHeight); 
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
                cylinder(d=M3BoltHexHeadDia,M3BoltHexHeadHeight+1);   
        }
}
module CaseBolts(){
    translate([0,0,CaseTopThickness - M3BoltHexHeadHeight])
        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(d=M3BoltDia,500,center=true);   
        }
}


module CaseTop(){
    render()
    difference(){
        union(){
            linear_extrude(CaseTopThickness)
            render()
            difference(){
                CaseBaseShape();
                translate(MainBoardRotaryEncoder)circle(d=5.5);
                translate(MainBoardButtons)circle(d=5);
                mirror([1,0,0])
                    translate(MainBoardButtons)circle(d=5);
            }   
            
            translate(MainBoardTFTDisplay)
                DisplayRisers();
        }
        
        translate(MainBoardTFTDisplay)
            DisplayHoles();
        

        CaseBoltHeads(); 
        CaseBolts();
    }    
}

module BoardMountingLips(){
    USBBoardLipHeight = 5.7;
    USBBoardLipLength = 8.5;
    MainBoardLipHeight = 12.5;
    
    mirror([0,0,1]){
        linear_extrude(USBBoardLipHeight){
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
                cylinder(d=10,MainBoardLipHeight);   
        }
    }
}

module CaseMid(){
    
    difference(){
        BoardMountingLips();
        CaseBolts();
    }
}

module CaseBottomLid(){
    render()
    difference(){
        union(){
            linear_extrude(CaseBottomThickness)
                CaseBaseShape();
            for(i = MainBoardMountingHoles){
                translate(i)
                    cylinder(d=10,2+CaseBottomThickness);   
            }
        }
        
        CaseBolts();
        for(i = MainBoardMountingHoles){
            translate(i)
                cylinder(d=M3NutDia,3,$fn=6);   
        }
    }
}

/*
linear_extrude(10)
difference(){
    CaseBaseShape();
    MainPCBShapeMargin();
}
*/

translate([0,0,14.2])CaseTop();
translate([0,0,14.2])CaseMid();
translate([0,0,-5.1])CaseBottomLid();

MainBoardComplete();