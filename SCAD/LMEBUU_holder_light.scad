//Klammer - Variablen
//wandstaerke=2;
//d_bushing=12;
//d_bushing_corr =0.5; // Korrektur für die lockere Öffnung;
//h_bushing=15;

use <LMEBUU_holder.scad>;
use <clamp.scad>;

//Klammer (unrotiert)
module LMEBUU_holder_light_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height) {
        outer_length = length+2*thickness_l;
        opening = 180;
        difference(){
            union(){
                //Klammer
                translate([0,0,thickness_l]) {
                    rotate([0,0,opening/2]){
                    rotate_extrude(angle = 360-opening){
                        square([thickness_w+diameter/2,length]);
                    }
                    }
                }
                //Basis
                b_width = diameter+thickness_w;
                b_length = length+2*thickness_l;
                b_height = diameter/2+base_height;
                translate([-b_height-thickness_w,-b_width/2,0]){
                    cube([b_height, b_width, b_length]);
                } 
      
            }
            translate([0,0,thickness_l]) {
                //Loch
                cylinder(d1=diameter,d2=diameter,h=length);
            }  
            //Loch Stange
            cylinder(d1=rod_diameter,d2=rod_diameter,h=outer_length);
        }
}

module LMEBUU_holder_light(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, center){
    if(center== true) {
        translate([0,-length/2-thickness_l,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_light_u(thickness_w,thickness_l, diameter, length,rod_diameter, base_height);
        }}
    } 
    else {
        translate([diameter/2+thickness_w,0,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_light_u(thickness_w,thickness_l, diameter, length,rod_diameter, base_height);
        }}
    }
}

//Klammer mit Kabelbinder-Aussparung (unrotiert)
module LMEBUU_holder_light_with_ct_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height,ct) {
    difference(){
        LMEBUU_holder_light_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height);
        LMEBUU_holder_ct_u(thickness_w,thickness_l, diameter, length, ct);
    }
}



module LMEBUU_holder_light_with_ct(thickness_w,thickness_l,diameter,length,rod_diameter,base_height,ct,center=false){
    if(center == true) {
        translate([0,-length/2-thickness_l,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_light_with_ct_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, ct);
        }}
    } 
    else {
        translate([diameter/2+thickness_w,0,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_light_with_ct_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, ct);
        }}
    }
}
$fn=50;
LMEBUU_holder_light_with_ct_u(2,2,16,25,10,5,[1.5,2], center=false);
//aussparungen(5, 2,16,25,5, [1.5,2], center=false);

