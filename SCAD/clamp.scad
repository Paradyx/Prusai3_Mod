//Klammer - Variablen
//wandstaerke=2;
//d_bushing=12;
//d_bushing_corr =0.5; // Korrektur für die lockere Öffnung;
//h_bushing=15;

oeffnung_geschlossen=90; //Winkel der öffnung
oeffnung_offen=210;

//Klammer (unrotiert)
module clamp_u(wandstaerke,d_bushing,h_bushing, basis_h, oeffnung) {
        difference(){
            union(){
                //Klammer
                rotate([0,0,oeffnung/2]){
                rotate_extrude(angle = 360-oeffnung){
                    square([wandstaerke+d_bushing/2,h_bushing]);
                }
                }
                //Basis
                b_breite = d_bushing+wandstaerke;
                b_lange = h_bushing;
                b_hoehe = d_bushing/2+basis_h;
                translate([-b_hoehe-wandstaerke,-b_breite/2,0]){
                    cube([b_hoehe, b_breite, b_lange]);
                } 
      
            }
            //Loch
            cylinder(d1=d_bushing,d2=d_bushing,h=h_bushing);
        }
}

module clamp(wandstaerke,d_bushing,h_bushing, basis_h, oeffnung, center){
    if(center== true) {
        translate([0,-h_bushing/2,d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            clamp_u(wandstaerke, d_bushing, h_bushing,basis_h, oeffnung, ct);
        }}
    } 
    else {
        translate([d_bushing/2+wandstaerke/2,0,d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            clamp_u(wandstaerke, d_bushing, h_bushing,basis_h, oeffnung, ct);
        }}
    }
}

//Aussparung (unrotiert)
module ct_aussparung_u(wandstaerke, d_bushing, h_bushing, ct){
    // Aussparung
    a_lange = 180;
    a_breite = ct[1];
    a_tiefe = ct[0];
    //Klammer
    translate([0,0,-a_breite/2 + h_bushing/2]){
        rotate([0,0,90]) {
            rotate_extrude(angle = 180){
                translate([d_bushing/2 + wandstaerke, 0]){
                    square([a_tiefe,a_breite]);
                }
            }
        }
       
    }    
}

//Aussparung 
module ct_aussparung(wandstaerke, d_bushing, h_bushing,basis_h, ct){
    if(center == true) {
         translate([0,-h_bushing/2,+d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            ct_aussparung_u(wandstaerke, d_bushing, h_bushing, ct);
        }}
    } 
    else {
        translate([d_bushing/2+wandstaerke/2,0,d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            ct_aussparung_u(wandstaerke, d_bushing, h_bushing, ct);
        }}
    }
}

//Klammer mit Kabelbinder-Aussparung (unrotiert)
module clamp_with_ct_u(wandstaerke,d_bushing,h_bushing,basis_h, oeffnung,ct) {
    difference(){
        clamp_u(wandstaerke, d_bushing, h_bushing,basis_h, oeffnung);
        ct_aussparung_u(wandstaerke, d_bushing, h_bushing, ct);
    }
}



module clamp_with_ct(wandstaerke,d_bushing,h_bushing, basis_h, oeffnung, ct, center=false){
    if(center == true) {
         translate([0,-h_bushing/2,+d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            clamp_with_ct_u(wandstaerke, d_bushing, h_bushing,basis_h, oeffnung, ct);
        }}
    } 
    else {
        translate([d_bushing/2+wandstaerke/2,0,d_bushing/2+wandstaerke+basis_h]){ rotate([0,-90,-90]) {
            clamp_with_ct_u(wandstaerke, d_bushing, h_bushing, basis_h, oeffnung, ct);
        }}
    }
}

