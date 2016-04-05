$fn=50;

include <clamp.scad>;
include <gt2_holder.scad>; 

//Achsenabstand (radius zu radius)
d_axis=45;

//Maße Grundplatte
gr_x=d_axis+12;
gr_y=56;
gr_z=4;

//Schrauben M3 Konstanten
d_m3=3.3; 
h_m3=15;

//Schrauben M4 Konstaten
d_m4=4.3;
h_m4=15;

//Schrauben Maße
d_s = d_m3; //Durchmesser
h_s = d_m3;

//Schraubenabstand
s_horizontal=11.5;
s_vertikal=11.5;

//Klammer
wandstaerke=2;
d_bushing=12;
d_bushing_corr =0.5; // Korrektur für die lockere Öffnung;
h_bushing=15;

//GT2 Holder
holder_height=12;

p_tweak1_x=-19;
p_tweak1_y=-8;
p_tweak1_z=-holder_height;

p_tweak2_x=+30;
p_tweak2_y=-8;
p_tweak2_z=-holder_height;

//Kabelbinder Maße
ct_x=1.5;
ct_y=3.5;
ct=[ct_x, ct_y];

//Federaussparung

    //breite Stelle
    fab_x = d_bushing+wandstaerke+3;
    fab_y = h_bushing+3;

    //dünne Stelle
    fad_x = 10;
    fad_y = 40;

//Federsteg
steg_y = fad_y; //Länge
steg_z = gr_z+1-d_bushing_corr/2; //So dick wie die Platte
steg_x = 2; // Dicke

//Grundplatte
difference(){
    //Platte    
    translate([-gr_x/2,-gr_y/2,0]){
        minkowski(){
            cube([gr_x,gr_y,gr_z]);
            cylinder(r=2,h=1); //Wird durch Zylinder gr_z+1 dick!
        }
    }

    //Schraubenlöcher recht
    translate([s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    translate([-s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    //Schraubenlöcher links
    translate([s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }

    translate([-s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    //Federausspraung breit stelle
    translate([-d_axis/2-fab_x/2,-fab_y/2,0]){
        cube([fab_x, fab_y, gr_z+1]);
 
    }
    
    //Federausspraung dünn stelle
    translate([-d_axis/2-fad_x/2,-fad_y/2,0]){
        cube([fad_x, fad_y, gr_z+1]);
 
    }
    
    //Federausspraung komplett (Material sparen)
    translate([-d_axis/2-fab_x-steg_x/2,-(gr_y+4)/2,0]){
        cube([fab_x, gr_y+4, gr_z+1]);
 
    }
}
 // Steg
translate([-steg_x/2-d_axis/2,-fad_y/2,0]){
    cube([steg_x, fad_y/2-h_bushing/2, steg_z]);
}
translate([-steg_x/2-d_axis/2,+h_bushing/2,0]){
    cube([steg_x, fad_y/2-h_bushing/2, steg_z]);
}

//Klammern

//Obere
translate([(d_bushing+wandstaerke)/2+d_axis/2,-gr_y/2,gr_z]){rotate([0,180,0]){
    clamp(wandstaerke,d_bushing,h_bushing,gr_z-wandstaerke, oeffnung_geschlossen);
}}

 //Obere
translate([(d_bushing+wandstaerke)/2+d_axis/2,+gr_y/2-h_bushing,gr_z]){rotate([0,180,0]){
    clamp(wandstaerke,d_bushing,h_bushing,gr_z-wandstaerke, oeffnung_geschlossen);
}}

//Untere in der Aussparung
translate([(d_bushing+wandstaerke)/2-d_axis/2,-h_bushing/2,gr_z+1]){rotate([0,180,0]){
    clamp_with_ct(wandstaerke,d_bushing,h_bushing,gr_z-wandstaerke+1,oeffnung_offen, ct); 
}}


gt2_holder(p_tweak1_x,p_tweak1_y,p_tweak1_z,holder_height);
gt2_holder(p_tweak2_x,p_tweak2_y,p_tweak2_z,holder_height);
