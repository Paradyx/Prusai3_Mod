wanddicke=1.5;
//Außenmaße
hoehe=20;
breite=20;
laenge=20;

difference(){
cube([breite,laenge,hoehe]);
translate([wanddicke,wanddicke,wanddicke])
cube([breite-2*wanddicke,laenge-2*wanddicke,hoehe-2*wanddicke]);
}