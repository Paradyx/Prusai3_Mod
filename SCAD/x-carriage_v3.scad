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
p_tweak1_x=-19;
p_tweak1_y=-8;
p_tweak1_z=-8;

p_tweak2_x=+30;
p_tweak2_y=-8;
p_tweak2_z=-8;

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


//GT2 Holder
module gt2_holder(position_tweak_x,position_tweak_y,position_tweak_z){
    rotate([0,0,90]){
        difference(){
            union(){
                for ( i = [0 : 5] ){
                        translate([0-i*2+position_tweak_x-1,position_tweak_y+0.5,position_tweak_z]) cube([1,7,8]);
                        translate([0-i*2+position_tweak_x-0.5,position_tweak_y+0.5,position_tweak_z]) cylinder(d1=1,d2=1,h=8);
                     }
                     
                translate([-11+position_tweak_x,0.75+0.5+position_tweak_y,position_tweak_z]){
                    cube ([11,6.75,8]);
                }
            
        }
            //Anfasung
            translate([0+position_tweak_x,5+position_tweak_y,+position_tweak_z]){
             rotate([0,0,45]){
                cube([10,10,15]);
             }
        }
            //Anfasung
            translate([-11+position_tweak_x,5+position_tweak_y,+position_tweak_z]){
             rotate([0,0,45]){
                cube([10,10,15]);
             }
        }
    }

    }
}

difference(){
    
    //Grundplatte
    translate([0,0,gr_z/2]){
        minkowski(){
         cube([gr_x,gr_y,gr_z], center=true);
         cylinder(r=2,h=1);
        }
    }
    
    //Schraubenlöcher recht
    translate([s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m3, d2=d_m3, h=h_m3);
    }
    
    translate([-s_horizontal,s_vertikal,0]){
        cylinder(d1=d_m3, d2=d_m3, h=h_m3);
    }
    
    //Scraubenlöcher links
    translate([s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    translate([-s_horizontal,-s_vertikal,0]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }

}

//Klammern

translate([d_axis/2,-gr_y/2-2,-wandstaerke/2-gr_z]){
//translate(d_axis/2,0,0){
    clamp(wandstaerke,d_bushing,h_bushing);
}

translate([d_axis/2,gr_y/2-h_bushing+2,-wandstaerke/2-gr_z]){
//translate(d_axis/2,0,0){
    clamp(wandstaerke,d_bushing,h_bushing);
}

translate([-d_axis/2,-gr_y/2-2,-wandstaerke/2-gr_z]){
//translate(d_axis/2,0,0){
    clamp(wandstaerke,d_bushing,h_bushing);
}

translate([-d_axis/2,gr_y/2-h_bushing+2,-wandstaerke/2-gr_z]){
//translate(d_axis/2,0,0){
    clamp(wandstaerke,d_bushing,h_bushing);
}

gt2_holder(p_tweak1_x,p_tweak1_y,p_tweak1_z);
gt2_holder(p_tweak2_x,p_tweak2_y,p_tweak2_z);
