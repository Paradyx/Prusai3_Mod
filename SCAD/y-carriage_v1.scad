$fn=50;

include <clamp.scad>;


//Schraubenabstand
s_abstand=28;

//Schrauben M3 Konstanten
d_m3=3.3; 
h_m3=15;

//Schrauben M4 Konstaten
d_m4=4.3;
h_m4=15;

//Schrauben Maße
d_s = d_m3; //Durchmesser
h_s= h_m3;

lochstaerke = 4;

//Maße Grundplatte
gr_x=s_abstand +lochstaerke*2+d_s;
gr_y=45;
gr_z=4;

//Kabelbinder Maße
ct_x=1.5; //Dicke
ct_y=3.5; //Breite
ct_z=gr_z+3; //Länge / Flexibilität
ct=[ct_x, ct_y, ct_z];

//Klammer
wandstaerke=2;
d_bushing=12;
d_bushing_corr =0.5; // Korrektur für die lockere Öffnung;
h_bushing=15;


//Federsteg
steg_y = gr_y-10; //Länge
steg_z = gr_z; //So dick wie die Platte
steg_x = 2; // Dicke



//Basisplatte
difference() {
    //Platte
    translate([-gr_x/2, -gr_y/2, -gr_z]) {
        cube([gr_x, gr_y, gr_z]);
    }
    
    //Schraubenlöcher
    translate([-s_abstand/2,0,-h_s]){
        cylinder(d1=d_s, d2=d_s, h=h_s);
    }
    translate([s_abstand/2,0,-h_s]){
        cylinder(d1=d_s, d2=d_s, h=h_s);
    }
    
    //Federaussparung
    gr_fx = s_abstand-d_s-2*lochstaerke;
    gr_fy = steg_y;
    gr_fz = gr_z;
    translate([-gr_fx/2, -gr_fy/2, -gr_fz]) {
        cube([gr_fx, gr_fy, gr_fz]);
    }
    
    //Eckenaussparung (Material sparen)
    gr_ex = lochstaerke;
    gr_ey = (gr_y-d_s)/2 - lochstaerke;
    gr_ez = gr_z;
    
    translate([-gr_x/2,-gr_y/2,-gr_z]) {
        cube([gr_ex, gr_ey, gr_ez]);
    }
    
    translate([-gr_x/2,gr_y/2-gr_ey,-gr_z]) {
        cube([gr_ex, gr_ey, gr_ez]);
    }
    translate([gr_x/2-gr_ex,gr_y/2-gr_ey,-gr_z]) {
        cube([gr_ex, gr_ey, gr_ez]);
    }
    translate([gr_x/2-gr_ex,-gr_y/2,-gr_z]) {
        cube([gr_ex, gr_ey, gr_ez]);
    }
   
}
 


//Klammer
translate([0,0,-gr_z]){
    clamp_with_ct(wandstaerke, d_bushing, h_bushing,gr_z-wandstaerke, oeffnung_offen, ct, center=true);
}

//Federsteg
translate([-steg_x/2,-steg_y/2,-gr_z]) {
        cube([steg_x, steg_y/2 - h_bushing/2, steg_z]);
}

translate([-steg_x/2,h_bushing/2,-gr_z]) {
        cube([steg_x, steg_y/2 - h_bushing/2, steg_z]);
}




