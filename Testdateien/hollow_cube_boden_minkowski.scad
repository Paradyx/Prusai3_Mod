wanddicke=.8;
//Außenmaße
hoehe=20;
breite=20-2*2;
laenge=20-2*2;
$fn=50;

difference(){
    minkowski(){
        cube([breite,laenge,hoehe]);
        cylinder(r=2,h=1);
    }
    translate([wanddicke,wanddicke,wanddicke]){
        minkowski(){
            cube([breite-2*wanddicke,laenge-2*wanddicke,hoehe-wanddicke]);
            cylinder(r=2,h=1);
        }
    }
}