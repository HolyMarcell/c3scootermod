
// simple scooter clamp:

// v0: 33mm inner (hollow) diameter
tieHeight = 6;
tieWidth = 3; 

module tieHole(inner, outter, height) {
  translate([0,0,(2*height/3)-(tieHeight/2)]) {
    difference() {
      cylinder(h=tieHeight, r=outter-((outter-inner)/2)+(tieWidth/2), center=false, $fn=200); 
      translate([0,0,-0.1]) {
        cylinder(h=tieHeight+0.2, r=inner+((outter-inner)/2)-(tieWidth/2), center=false, $fn=200); 
      }
    }
  }
}
module clamp (inner, outter, height, degree) {
   
   translate([0,0,0]) {
    difference() {
      cylinder(h=height, r=outter, center=false, $fn=200); 

      // cut out middle
      translate([0,0,-0.1]) {
        cylinder(h=height+0.2, r=inner, center=false, $fn=200); 
      }

      // Cut a Hole for the zip ties
      tieHole(inner, outter, height);

      // Remove half of the circly
      translate([-outter-0.1,-0.1,-0.1]) {
        cube(size=[2*outter+0.2, 2*outter, height+0.2], center=false);
      }

      // remove certain degree of the rest
      // -- Magic math does remove more of the 180deg that were left
      rotate([0,0,180-degree]) {

        translate([-outter-0.1,-0.1,-0.1]) {
          cube(size=[2*outter+0.2, 2*outter, height+0.2], center=false);
        }
      }

    }
   }
 }
//clamp(33/2, 43/2, 20, 60);
