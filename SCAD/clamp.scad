//Klammer - Variablen
//thickness=2;
//diameter=12;
//diameter_corr =0.5; // Korrektur für die lockere Öffnung;
//length=15;

opening_closed=90; //Winkel der öffnung
opening_open=210;

//Klammer (unrotiert)
module clamp_u(thickness,diameter,length,base_height, opening) {
        difference(){
            union(){
                //Klammer
                rotate([0,0,opening/2]){
                rotate_extrude(angle = 360-opening){
                    square([thickness+diameter/2,length]);
                }
                }
                //Basis
                b_width = diameter+thickness;
                b_length = length;
                b_height = diameter/2+base_height;
                translate([-b_height-thickness,-b_width/2,0]){
                    cube([b_height, b_width, b_length]);
                } 
      
            }
            //Loch
            cylinder(d1=diameter,d2=diameter,h=length);
        }
}

module clamp(thickness,diameter,length,base_height, opening, center){
    if(center== true) {
        translate([0,-length/2,diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_u(thickness, diameter, length,base_height, opening);
        }}
    } 
    else {
        translate([diameter/2+thickness/2,0,diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_u(thickness, diameter, length,base_height, opening);
        }}
    }
}

//Aussparung (unrotiert)
module clamp_ct_u(thickness, diameter, length, ct){
    // Aussparung
    a_length = 180;
    a_width = ct[1];
    a_depth = ct[0];
    //Klammer
    translate([0,0,-a_width/2 + length/2]){
        rotate([0,0,90]) {
            rotate_extrude(angle = 180){
                translate([diameter/2 + thickness, 0]){
                    square([a_depth,a_width]);
                }
            }
        }
       
    }    
}

//Aussparung 
module clamp_ct(thickness, diameter, length,base_height, ct, center=false){
    if(center == true) {
         translate([0,-length/2,+diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_ct_u(thickness, diameter, length, ct);
        }}
    } 
    else {
        translate([diameter/2+thickness/2,0,diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_ct_u(thickness, diameter, length, ct);
        }}
    }
}

//Klammer mit Kabelbinder-Aussparung (unrotiert)
module clamp_with_ct_u(thickness,diameter,length,base_height, opening,ct) {
    difference(){
        clamp_u(thickness, diameter, length,base_height, opening);
        clamp_ct_u(thickness, diameter, length, ct);
    }
}



module clamp_with_ct(thickness,diameter,length,base_height, opening, ct, center=false){
    if(center == true) {
         translate([0,-length/2,+diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_with_ct_u(thickness, diameter, length,base_height, opening, ct);
        }}
    } 
    else {
        translate([diameter/2+thickness/2,0,diameter/2+thickness+base_height]){ rotate([0,-90,-90]) {
            clamp_with_ct_u(thickness, diameter, length,base_height, opening, ct);
        }}
    }
}

clamp(2, 16, 25, 0,180, [1.5, 2]);


