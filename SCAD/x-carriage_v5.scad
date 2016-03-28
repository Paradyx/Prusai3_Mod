$fn=50;

//Maße Grundplatte
//gr_x=75;
gr_x=60;
gr_y=56;
gr_z=5;

//Schrauben links
d_m3=3.3; //Durchmesser
h_m3=15;

//Schrauben rechts
d_m4=4.3;
h_m4=15;

//Schraubenabstand
s_horizontal=11.5;
s_vertikal=11.5;

//Klammer
wandstaerke=2;
d_bushing=12;
h_bushing=15;

//Achsenabstand (radius zu radius)
d_axis=45;

//GT2 Holder
holder_height=12;

p_tweak1_x=-19;
p_tweak1_y=-8;
p_tweak1_z=-holder_height;

p_tweak2_x=+30;
p_tweak2_y=-8;
p_tweak2_z=-holder_height;

//Kabelbinder Maße
ct_x=2;
ct_y=3.5;
ct_z=gr_z+5;


module clamp(wandstaerke,d_bushing,h_bushing) {
    
    rotate([0,90,90]){
        //Klammer
        rotate([0,0,45]){
        rotate_extrude(angle = 270){
            translate([6, 0, 0])
            square([wandstaerke,h_bushing]);
        }
        }

        //Klammerplatte
        difference(){
            translate([-(d_bushing)/2+wandstaerke/2,0,h_bushing/2]){
                cube([d_bushing/2,d_bushing+wandstaerke,h_bushing], center=true);
            }
            
            cylinder(d1=d_bushing,d2=d_bushing,h=h_bushing);
        }
    }

}

module clamp_short(wandstaerke,d_bushing,h_bushing) {
    
    rotate([0,90,90]){
        //Klammer
        rotate([0,0,105]){
        rotate_extrude(angle = 150){
            translate([6, 0, 0])
            square([wandstaerke,h_bushing]);
        }
        }

        //Klammerplatte
        difference(){
            translate([-(d_bushing)/2+wandstaerke/2,0,h_bushing/2]){
                cube([d_bushing/2,d_bushing+wandstaerke,h_bushing], center=true);
            }
            
            cylinder(d1=d_bushing,d2=d_bushing,h=h_bushing);
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

difference(){
    
    //Grundplatte
    union (){
        
        //Klammern

        //Obere
        translate([d_axis/2,-gr_y/2-2,-wandstaerke/2-gr_z]){
            clamp(wandstaerke,d_bushing,h_bushing);
        }

        translate([d_axis/2,gr_y/2-h_bushing+2,-wandstaerke/2-gr_z]){
            clamp(wandstaerke,d_bushing,h_bushing);
        }
        
        //Untere
        //links
        translate([-d_axis/2,-gr_y/2-2,-wandstaerke/2-gr_z]){
            clamp_short(wandstaerke,d_bushing,h_bushing);
        }

        //rechts
        translate([-d_axis/2,gr_y/2-h_bushing+2,-wandstaerke/2-gr_z]){
            clamp_short(wandstaerke,d_bushing,h_bushing);
        }
        translate([0,0,gr_z/2]){
            minkowski(){
                cube([gr_x,gr_y,gr_z], center=true);
                cylinder(r=2,h=1);
            }
        }
   
    }
    //Schraubenlöcher recht
    translate([s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    translate([-s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    //Scraubenlöcher links
    translate([s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }

    translate([-s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }

    //Kabelbinder Rechts
    //Kabelbinder rechts unten
    translate([-d_axis/2-8,gr_y/2-h_bushing+2+7.5-ct_x,-2]){
        cube([ct_x,ct_y,ct_z]);
    }   
    
    //Kabelbinder rechts oben
    translate([-d_axis/2-7+d_bushing+wandstaerke,gr_y/2-h_bushing+2+7.5-ct_x,-2]){
        cube([ct_x,ct_y,ct_z]);
    }
    
    //Kabelbinder aussparung rechts
    translate([-d_axis/2-8,gr_y/2-h_bushing+2+7.5-ct_x,gr_z-.75]){
        cube([(ct_x+d_bushing+wandstaerke),ct_y,1.75]);
    }
    
    //Kabelbinder Links
    //Kabelbinder links unten
    translate([-d_axis/2-8,-gr_y/2-2+7.5-ct_y/2,-2]){
        cube([ct_x,ct_y,ct_z]);
    }   
    
    //Kabelbinder links oben
    translate([-d_axis/2-7+d_bushing+wandstaerke,-gr_y/2-2+7.5-ct_y/2,-2]){
        cube([ct_x,ct_y,ct_z]);
    }
    
    //Kabelbinder aussparung links
    translate([-d_axis/2-8,-gr_y/2-2+7.5-ct_y/2,gr_z-.75]){
        cube([(ct_x+d_bushing+wandstaerke),ct_y,1.75]);
    }
    
}

gt2_holder(p_tweak1_x,p_tweak1_y,p_tweak1_z,holder_height);
gt2_holder(p_tweak2_x,p_tweak2_y,p_tweak2_z,holder_height);
