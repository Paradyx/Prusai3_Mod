// modified version of http://www.thingiverse.com/thing:1256069
// Auto Bed Leveling Probe Mount for the Robotdigg Aluminium Kossel Effector by Karatektus is licensed under the Creative Commons - Attribution license. 

$fn = 100;

length = 60;
diameter = 18.5;
thickness = 7;

height_of_plate=5;
height= 5;
depth = 4;

screw_diameter=3.1;

length_of_arm=6;

difference(){
    difference(){
        translate([0, (diameter/2)+(thickness/2)+depth/2, length/2]){
            cube([11, depth, length], center=true);
        }
        translate([0,(diameter/2)+(thickness/2)+(36/2)+depth-2,0]){
            //cylinder(r = 36/2, h=length); // hintere Abrundung
        }
        
    }
    translate([0, (diameter/2)+(thickness/2)+depth, length-(height_of_plate/2)-3]){
        rotate([90, 0, 0]){
            cylinder(r=screw_diameter/2, h=depth); // Schraubenloch 1
        }
    }
    translate([0, (diameter/2)+(thickness/2)+depth, length-(height_of_plate/2)-3-23]){
        rotate([90, 0, 0]){
            cylinder(r=screw_diameter/2, h=depth); // Schraubenloch 2
        }
    }

}
difference() {
    hull(){
        translate([0, (diameter/2)+(thickness/2), height / 2]){
            cube([11, 8, height], center=true);
        }

        difference() {
            cylinder(r = (diameter/2)+(thickness / 2), h = height);
            cylinder(r = diameter/2, h = height);
        }
    }
    cylinder(r = diameter/2, h = height);
    translate([0,-((diameter/2)+thickness)/2,height/2]){
        cube([diameter+thickness, (diameter/2)+thickness, height], center=true);
    }
}


// Addition to the front to allow for more mounting space
translate([diameter/2,-length_of_arm,0]){
     cube([thickness/2,length_of_arm,height]);
}
translate([-diameter/2-thickness/2,-length_of_arm,0]){
     cube([thickness/2,length_of_arm,height]);
}
