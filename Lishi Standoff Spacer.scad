height=9.25;
width=2.7;
wall=1;
topwidth=1.5;
topheight=3;
topangle=55;
thickness=4.20;
fn=8;
$fn=pow(2,fn);

module inside(width, height) {
square([width, height], center=true);
}

module corner(wall, angle) {
	rotate(angle)
	translate([-wall/2,-wall/2,0])
	intersection(){
	square([wall,wall]);
	circle(wall);
	}
}

module outside(width, height, wall) {
	x=(width+wall)/2;
	y=(height+wall)/2;
	translate([0,y,0])
	square([width, wall], center=true);
	translate([0,-y,0])
	square([width, wall], center=true);
	translate([x,0,0])
	square([wall, height], center=true);
	translate([-x,0,0])
	square([wall, height], center=true);
	
	translate([x,y,0]) corner(wall, 0);
	translate([-x,y,0]) corner(wall, 90);
	translate([-x,-y,0]) corner(wall, 180);
	translate([x,-y,0]) corner(wall, 270);
}

module key(width, height, topwidth, topheight, topangle) {
	w = width-topwidth;
	translate([topwidth/2,(topheight-height)/2,0]) {
		square([w,topheight],center=true);
		translate([0,topheight/2,0])
			polygon([[-w/2,0],[w/2,0],[w/2,tan(topangle)*w]]);
	}
}

difference () {
	outside(width, height, wall);
	inside(width, height);
}
key(width, height, topwidth, topheight, topangle);


