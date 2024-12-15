/* [Tool Dimensions] */
// Blade height (at the shoulder)
bladeHeight=9.25;
// How far down the keyway the angle should start
bladeUpperHeight=3;
// Thickness of the blade at the top
bladeUpperThickness=1.5;
// How far up the keyway the angle should start
bladeLowerHeight=4.5;
// Thickness of the blade at the bottom
bladeLowerThickness=2.7;
// The pin spacing - this will be the distance the standoff pushes the tool out
pinSpacing=4.20;
/* [Printing/Rendering Options]*/
// How much material to use
collarWidth=1; 
// The resolution used to calculate curves - as a power of two
curveResolution=8; // [4:8]

$fn=pow(2,curveResolution);

linear_extrude(pinSpacing) {
	difference() {
		body(bladeHeight, bladeLowerThickness, collarWidth);
		inside(bladeHeight, bladeLowerHeight, bladeLowerThickness, bladeUpperHeight, bladeUpperThickness); 
	}
}

/* Functions */

module corners(x, y, radius) {
	for (i=[0:1]) {
		for (k=[0:1]) {
			mirror([i,0,0]) {
				mirror([0,k,0]) {
					corner(x, y, radius);
				}
			}
		}
	}
}

module corner(x, y, radius) {
	translate([x - radius/2, y - radius/2, 0]) {
		intersection() {
			square([radius, radius]);
			circle(radius);
		}
	}
}

module body(height, width, collarWidth) {
	x = (width + collarWidth) / 2;
	y = (height + collarWidth) / 2;
	
	square([width, height + 2 * collarWidth], center=true);
	square([width + 2 * collarWidth, height], center=true);
	corners(x, y, radius=collarWidth);
}

module inside(bladeHeight, bladeLowerHeight, bladeLowerThickness, bladeUpperHeight, bladeUpperThickness) {
	x = bladeLowerThickness / 2;
	y = bladeHeight / 2;
	polygon(
		[
			[-x,bladeLowerHeight-y],
			[-x,-y],
			[x,-y],
			[x,y],
			[x-bladeUpperThickness,y],
			[x-bladeUpperThickness,y-bladeUpperHeight]
		]
	);
}