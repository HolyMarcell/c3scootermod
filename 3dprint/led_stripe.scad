// -- LED stripe
include <./clamp/connector_v1.scad>

chunkLen=270;
stripWidth=8;

module stripe() {
  
  difference() {
    cube(size=[stripWidth+2, chunkLen, 2], center=false);
    translate([1, -0.1, 1]) {
      cube(size=[stripWidth, chunkLen+0.2, 2], center=false);
    }
    translate([(stripWidth+2)/2, 10, -3]) {
      inserter(3.2);
    }
    translate([(stripWidth+2)/2, chunkLen-10+1, -3]) {
      inserter(3.2);
    }
  }
}


stripe();