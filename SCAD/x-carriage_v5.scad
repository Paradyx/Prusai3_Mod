$fn=50;

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

oeffnung_geschlossen=90; //Winkel der öffnung
oeffnung_offen=210;

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
ct_z=gr_z+3;

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


//Klammerplatte
module clamp(wandstaerke,d_bushing,h_bushing, oeffnung, d_bushing_corr=0) {
    rotate([0,90,90]){
        difference(){
            union(){
                //Klammer
                rotate([0,0,oeffnung/2]){
                rotate_extrude(angle = 360-oeffnung){
                    square([wandstaerke+d_bushing/2,h_bushing]);
                }
                }
                //Basis
                translate([-(d_bushing)/2+wandstaerke/2-gr_z/2,0,h_bushing/2]){
                    cube([d_bushing/2+gr_z/2,d_bushing+wandstaerke,h_bushing], center=true);
                } 
      
            }
            //Loch
            cylinder(d1=d_bushing+d_bushing_corr,d2=d_bushing+d_bushing_corr,h=h_bushing);
        }
    }
}


//GT2 Holder
module gt2_holder(position_tweak_x,position_tweak_y,position_tweak_z,holder_height){
    rotate([0,0,90]){
        difference(){
            union(){
                for ( i = [0 : 5] ){
                        translate([0-i*2+position_tweak_x-1,position_tweak_y+0.5,position_tweak_z]) cube([1,7,holder_height]);
                        translate([0-i*2+position_tweak_x-0.5,position_tweak_y+0.5,position_tweak_z]) cylinder(d1=1,d2=1,h=holder_height);
                     }
                     
                translate([-11+position_tweak_x,0.75+0.5+position_tweak_y,position_tweak_z]){
                    cube ([11,6.75,holder_height]);
                }
            
        }
            //Anfasung
            translate([0+position_tweak_x,5+position_tweak_y,+position_tweak_z]){
             rotate([0,0,45]){
                cube([10,10,holder_height]);
             }
        }
            //Anfasung
            translate([-11+position_tweak_x,5+position_tweak_y,+position_tweak_z]){
             rotate([0,0,45]){
                cube([10,10,holder_height]);
             }
        }
    }

    }
}

//Klammern

        //Obere
        translate([d_axis/2,-gr_y/2-2,-wandstaerke-gr_z]){
            clamp(wandstaerke,d_bushing,h_bushing, oeffnung_geschlossen);
        }

        translate([d_axis/2,gr_y/2-h_bushing+2,-wandstaerke-gr_z]){
            clamp(wandstaerke,d_bushing,h_bushing, oeffnung_geschlossen);
        }
        
        //Untere mit Steg in der Aussparung
        translate([-d_axis/2,-h_bushing/2,-wandstaerke-gr_z]){
            difference(){
                union(){
                    //Klammer
                    clamp(wandstaerke,d_bushing,h_bushing,oeffnung_offen, d_bushing_corr); //Große Öffnung + 0.2, weil nicht klippen soll
                    
                    // Steg
                    translate([-steg_x/2,-fad_y/2+h_bushing/2,d_bushing/2+d_bushing_corr/2]){
                        cube([steg_x, fad_y, steg_z]);
                 
                    }
                }
                //Kabelbinder oben
                translate([(d_bushing+wandstaerke)/2-ct_x,-ct_y/2+h_bushing/2,d_bushing/2+gr_z-ct_z+1]){
                    cube([ct_x+1,ct_y,ct_z]);
                }
                
                //Kabelbinder untere
                translate([-(d_bushing+wandstaerke)/2-1,-ct_y/2+h_bushing/2,d_bushing/2+gr_z-ct_z+1]){
                    cube([ct_x+1,ct_y,ct_z]);
                }
                
                //Kabelbinder aussparung 
                translate([-(ct_x+d_bushing+wandstaerke)/2,-ct_y/2+h_bushing/2,d_bushing/2+gr_z-ct_x/2]){
                    cube([(ct_x+d_bushing+wandstaerke),ct_y,ct_x+1]);
                }
            }
        }
        
        


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

    //Kabelbinder Rechts
//    //Kabelbinder rechts unten
//    translate([-d_axis/2-8,gr_y/2-h_bushing+2+7.5-ct_x,-2]){
//        cube([ct_x,ct_y,ct_z]);
//    }   
//    
//    //Kabelbinder rechts oben
//    translate([-d_axis/2-7+d_bushing+wandstaerke,gr_y/2-h_bushing+2+7.5-ct_x,-2]){
//        cube([ct_x,ct_y,ct_z]);
//    }
//    
//    //Kabelbinder aussparung rechts
//    translate([-d_axis/2-8,gr_y/2-h_bushing+2+7.5-ct_x,gr_z-.75]){
//        cube([(ct_x+d_bushing+wandstaerke),ct_y,1.75]);
//    }
//    
//    //Kabelbinder Links
//    //Kabelbinder links unten
//    translate([-d_axis/2-8,-gr_y/2-2+7.5-ct_y/2,-2]){
//        cube([ct_x,ct_y,ct_z]);
//    }   
//    
//    //Kabelbinder links oben
//    translate([-d_axis/2-7+d_bushing+wandstaerke,-gr_y/2-2+7.5-ct_y/2,-2]){
//        cube([ct_x,ct_y,ct_z]);
//    }
//    
//    //Kabelbinder aussparung links
//    translate([-d_axis/2-8,-gr_y/2-2+7.5-ct_y/2,gr_z-.75]){
//        cube([(ct_x+d_bushing+wandstaerke),ct_y,1.75]);
//    }
    
}

gt2_holder(p_tweak1_x,p_tweak1_y,p_tweak1_z,holder_height);
gt2_holder(p_tweak2_x,p_tweak2_y,p_tweak2_z,holder_height);
