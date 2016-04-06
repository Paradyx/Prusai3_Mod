$fn=50;

use <LMEBUU_holder.scad>;
use <gt2_holder.scad>; 

//Achsenabstand (radius zu radius)
d_axis=45;

//LMEBUU Holder
L_thickness=2;
L_diameter=16;
L_length=25;
L_rod_diameter=10;

//Maße Grundplatte
gr_x=d_axis+L_diameter+2*L_thickness;
gr_y=2*L_length + 3*L_thickness;
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

//GT2 Holder
holder_height=10;

p_tweak1_x=-17;
p_tweak1_y=-6;
p_tweak1_z=-holder_height;

p_tweak2_x=+28;
p_tweak2_y=-6;
p_tweak2_z=-holder_height;

//Kabelbinder Maße
ct_x=1.5;
ct_y=3.5;
ct=[ct_x, ct_y];


//Grundplatte
difference(){
    union(){
        //Platte   
        mink_r = 2;
        mink_h = 1; 
        translate([-gr_x/2+mink_r,-gr_y/2+mink_r,0]){
            minkowski(){
                difference(){
                    cube([gr_x-2*mink_r,gr_y-2*mink_r,gr_z-mink_h]);
                    
                    cube([gr_x/2-(8+p_tweak1_y), gr_y/2 - L_length/2 - L_thickness, gr_z-mink_h]);
                    
                    translate([0,gr_y/2+ L_length/2-mink_r,0]) {
                        cube([gr_x/2-(8+p_tweak1_y), gr_y/2 - L_length/2 - L_thickness, gr_z-mink_h]);
                    }
                }
                cylinder(r=2,h=1); //Wird durch Zylinder gr_z+1 dick!
            }
        }
        
        //LMEBUU Holder Obere
        translate([L_thickness+L_diameter/2+d_axis/2,-L_thickness/2,0]){rotate([0,180,0]){
            LMEBUU_holder(L_thickness,L_thickness,L_diameter,L_length,L_rod_diameter,0);    
        }}
        translate([L_thickness+L_diameter/2+d_axis/2,-L_length-1.5*L_thickness,0]){rotate([0,180,0]){
            LMEBUU_holder(L_thickness,L_thickness,L_diameter,L_length,L_rod_diameter,0);  
        }}
        
        //LMEBUU Holder Unterer
        translate([L_thickness+L_diameter/2-d_axis/2,-L_length/2-L_thickness]){rotate([0,180,0]){
            LMEBUU_holder(L_thickness,L_thickness,L_diameter,L_length,L_rod_diameter,0);    
        }}
        
        // GT2 Holder
        gt2_holder(p_tweak1_x,p_tweak1_y,p_tweak1_z,holder_height);
        gt2_holder(p_tweak2_x,p_tweak2_y,p_tweak2_z,holder_height);
        
        //Erhöhung für Schraublöcher Oben
        eso_width = d_s+2*L_thickness;
        eso_length= gr_y;
        eso_height= L_diameter/2;
        
        translate([mink_r + d_axis/2-L_diameter/2-2*L_thickness-d_s,-eso_length/2+mink_r,-eso_height]){
           minkowski(){
                cube([eso_width-2*mink_r,eso_length-2*mink_r,eso_height-mink_h]);
                union(){
                    cylinder(r=2,h=1); //Wird durch Zylinder gr_z+1 dick!
                    translate([0,-mink_r,0]){
                        cube([mink_r,2*mink_r,mink_h]);
                    }
                }
           }
        }
        
        //Erhöhung für Schraublöcher Unten
        esu_width = d_s+2*L_thickness;
        esu_length= L_length+2*L_thickness;
        esu_height= L_diameter/2;
        translate([mink_r-d_axis/2+L_diameter/2,-esu_length/2+mink_r,-esu_height]){
           minkowski(){
                cube([esu_width-2*mink_r,esu_length-2*mink_r,esu_height-mink_h]);
                union(){
                    cylinder(r=2,h=1); //Wird durch Zylinder gr_z+1 dick!
                    translate([-mink_r,-mink_r,0]){
                        cube([mink_r,2*mink_r,mink_h]);
                    }
                }
           }
        }
    
    }
    
    //Kabelbinder Obere
    translate([L_thickness+L_diameter/2+d_axis/2,-L_thickness/2,0]){rotate([0,180,0]){
        LMEBUU_holder_cts(L_thickness, L_thickness,L_diameter,L_length,0, ct, amount=2);
    }}
    translate([L_thickness+L_diameter/2+d_axis/2,-L_length-1.5*L_thickness,0]){rotate([0,180,0]){
        LMEBUU_holder_cts(L_thickness, L_thickness,L_diameter,L_length,0, ct, amount=2);
    }}
    
    //Kabelbinder Untere
     translate([L_thickness+L_diameter/2-d_axis/2,-L_length/2-L_thickness,-0.01]){rotate([0,180,0]){
        LMEBUU_holder_cts(L_thickness, L_thickness, L_diameter, L_length,0, ct, amount=1);
    }}
    
    

    //Schraubenlöcher recht
    translate([s_horizontal,s_vertikal,-L_diameter/2-0.01]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    translate([-s_horizontal,s_vertikal,-L_diameter/2-0.01]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
    //Schraubenlöcher links
    translate([s_horizontal,-s_vertikal,-L_diameter/2-0.01]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }

    translate([-s_horizontal,-s_vertikal,-L_diameter/2-0.01]){
        cylinder(d1=d_m4, d2=d_m4, h=h_m4);
    }
    
 
}






