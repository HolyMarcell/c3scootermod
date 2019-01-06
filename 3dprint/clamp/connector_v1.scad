include <./clamp_v1.scad>



 

module inserter(scale) { 

  holeHeight=scale/3;
  holeDiameter=scale/1.3;

  // -- insertion wings
  // inserter
  translate([0, 0, 1.5*holeHeight]) {
    // pinhole
    cylinder(h=scale+2*holeHeight, r=holeDiameter, center=false, $fn=200);  
    difference() {
      cylinder(h=scale/2, r=1.5*scale, center=false, $fn=200);

      translate([holeDiameter/2, -1.5*scale, -0.1]) {
        cube(size=[3*scale, 3*scale, 3*scale], center=false);
      }

      translate([-3*scale-holeDiameter/2, -1.5*scale, -0.1]) {
        cube(size=[3*scale, 3*scale, 3*scale], center=false);
      }
    } 
  }
}





module cf(scale, rotate, outwards) {

  holeHeight=scale/3;
  holeDiameter=scale/1.3;
  r=90 - rotate/2;

  translate([sin(r)*(outwards-scale), -cos(r)*(outwards-scale), 0]){ // magic math: rotate the hole matching to the clamp.
    // it moves to the middle of the radial part of the clamp
    rotate([90,0,r]) {


      // opening for the inserter. scaled to cut a "long" enough
      translate([0,0,-3*holeHeight]) {
        scale([1,1,2]) {
          inserter(scale); 
        }
        
      }

      difference() {

        // rotation-hole fullwing
        translate([0,0,0]) {
          cylinder(h=scale/2, r=1.5*scale, center=false, $fn=200);
        }

        // remove wing
        translate([holeDiameter/2,holeDiameter/2,-0.1]) { 
          cube(size=[2*scale, 2*scale, scale+0.2], center=false);
        }

        // remove wing
        translate([-holeDiameter/2,-holeDiameter/2,-0.1]) {
          rotate([0,0,180]) {
            cube(size=[2*scale, 2*scale, scale+0.2], center=false);
          }
        }
        

        // arreting nipples

        translate([-1.5*scale-0.7,0.8,-0.1]) {
          cylinder(h=scale/2+0.2, r=1, center=false, $fn=200);
        }
        translate([1.5*scale+0.7,-0.8,-0.1]) {
          cylinder(h=scale/2+0.2, r=1, center=false, $fn=200);
        }

      }


    } 
  }

}


module connector_fem(scale, inner, outter, height, degree) {
  difference() {
    clamp(inner, outter, height, degree);
    translate([0,0,2*scale]){
      cf(scale, degree, outter); 
    }
    
  }
}

module connector_mal(scale) {
  scale([0.94, 0.94, 0.94]){
    inserter(scale);
  }
}

