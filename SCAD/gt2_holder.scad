

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