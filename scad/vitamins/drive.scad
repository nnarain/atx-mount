// SSDs and HDDs

bind = 0.001;
plate_scale = 0.85;


function drive_dimensions(spec) = spec[0];
function drive_length(spec) = drive_dimensions(spec)[0];
function drive_width(spec) = drive_dimensions(spec)[1];
function drive_height(spec) = drive_dimensions(spec)[2];

function drive_bottom_mounting_holes(spec) = spec[1];
function drive_side_mounting_holes(spec) = spec[2];
function drive_mounting_hole_radius(spec) = spec[3];

module base(spec) {
    cube(drive_dimensions(spec));
}

module bottom_mounting_holes(spec) {
    for (p = drive_bottom_mounting_holes(spec))
        translate([p[0], p[1], -drive_height(spec) / 2])
            cylinder(r=drive_mounting_hole_radius(spec), h=drive_height(spec));
}

module side_mounting_holes(spec) {
    cyl_h = drive_height(spec) / 2;

    for (p = drive_side_mounting_holes(spec)) {
        translate([p[0], cyl_h/2, p[1]])
            rotate([90, 0, 0])
                cylinder(r=drive_mounting_hole_radius(spec), h=cyl_h);
        translate([p[0], (drive_width(spec) + cyl_h) - cyl_h/2, p[1]])
            rotate([90, 0, 0])
                cylinder(r=drive_mounting_hole_radius(spec), h=cyl_h);
    }
}

module plate(spec) {
    // A colored plate on the top of the drive
    dl = drive_length(spec);
    pl = dl * plate_scale;
    dw = drive_width(spec);
    pw = dw * plate_scale;
    pt = 0.1;

    translate([(dl * (1-plate_scale)) / 2, (dw * (1 - plate_scale)) / 2, drive_height(spec) - bind])
        cube([pl, pw, pt]);
}

module drive(spec) {
    union() {
        color("silver")
        difference() {
            difference() {
                base(spec);
                bottom_mounting_holes(spec);
            }
            side_mounting_holes(spec);
        }
        color("palegreen")
            plate(spec);
    }
}
