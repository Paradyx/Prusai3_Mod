//Klammer - Variablen
//wandstaerke=2;
//d_bushing=12;
//d_bushing_corr =0.5; // Korrektur für die lockere Öffnung;
//h_bushing=15;

//Klammer (unrotiert)
module LMEBUU_holder_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height) {
        outer_length = length+2*thickness_l;
        opening = 180;
        difference(){
            //Basis
            b_width = diameter+2*thickness_w;
            b_length = outer_length;
            b_height = diameter/2+base_height;
            
            minik_r = 2;
            minik_h = 1;
            translate([-b_height,-b_width/2+minik_r,minik_r]){
                minkowski(){
                    cube([b_height-minik_h, b_width-2*minik_r, b_length-2*minik_r]);
                    rotate([0,90,0]){
                        cylinder(r=minik_r,h=minik_h); //Wird durch Zylinder gr_z+1 dick!
                    }
                }
                
                
            } 
      
            //Loch LMEBUU
            translate([0,0,thickness_l]){
                cylinder(d1=diameter,d2=diameter,h=length);
            }
            
            //Loch Stange
            translate([0,0,0]){
                cylinder(d1=rod_diameter,d2=rod_diameter,h=outer_length);
            }
        }
}

module LMEBUU_holder(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, center){
    if(center== true) {
        translate([0,-length/2-thickness_l,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_u(thickness_w,thickness_l, diameter, length,rod_diameter, base_height);
        }}
    } 
    else {
        translate([diameter/2+thickness_w,0,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_u(thickness_w,thickness_l, diameter, length,rod_diameter, base_height);
        }}
    }
}

//Aussparung (unrotiert)
module LMEBUU_holder_cts_u(thickness_w,thickness_l, diameter, length, ct, amount = 2){
    // Aussparung
    a_length = 180;
    a_width = ct[1];
    a_depth = ct[0];
    
    step = [0, 0.5, 0.25];
    steps = [[], [1], [1,3]];
    for(i = steps[amount]){
       translate([0,0,-a_width/2 + i*step[amount]*(length+2*thickness_l)]){
        rotate([0,0,90]) {
            rotate_extrude(angle = 180){
                translate([diameter/2+thickness_l, 0]){
                    square([a_depth,a_width]);
                }
            }
        }
    }    
    }
}

//Aussparung 
module LMEBUU_holder_cts(thickness_w,thickness_l, diameter, length, base_height,ct, amount, center=false){
    if(center == true) {
        translate([0,-length/2-thickness_l,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_cts_u(thickness_w,thickness_l,diameter,length, ct, amount);
        }}
    } 
    else {
        translate([diameter/2+thickness_w,0,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_cts_u(thickness_w,thickness_l,diameter,length, ct, amount);
        }}
    }
}

//Klammer mit Kabelbinder-Aussparung (unrotiert)
module LMEBUU_holder_with_cts_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height,ct, amount_cts) {
    difference(){
        LMEBUU_holder_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height);
        LMEBUU_holder_cts_u(thickness_w,thickness_l, diameter, length, ct, amount_cts);
    }
}



module LMEBUU_holder_with_cts(thickness_w,thickness_l,diameter,length,rod_diameter,base_height,ct,amount_cts, center=false){
    if(center == true) {
        translate([0,-length/2-thickness_l,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_with_cts_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, ct, amount_cts);
        }}
    } 
    else {
        translate([diameter/2+thickness_w,0,base_height+diameter/2]){ rotate([0,-90,-90]) {
            LMEBUU_holder_with_cts_u(thickness_w,thickness_l,diameter,length,rod_diameter, base_height, ct, amount_cts);
        }}
    }
}
$fn=50;
LMEBUU_holder_with_cts(5,2,16,25,10,0,[1.5,3.5],0, center=false);
//aussparungen(5, 2,16,25,5, [1.5,2], center=false);

