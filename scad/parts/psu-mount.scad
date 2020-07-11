include <../NopSCADlib/lib.scad>
use <../NopSCADlib/psu.scad>
use <../NopSCADlib/psus.scad>

psu_type = ATX500;

psu_dims = [psu_length(psu_type), psu_width(psu_type), psu_height(psu_type)];

// Thickness of the outer frame
frame_thickness = 10;

length = psu_dims[0] + frame_thickness;
width = psu_dims[1] + frame_thickness;
height = psu_dims[2] + frame_thickness;

function psu_type() = psu_type;
function psu_mount_length() = length;
function psu_mount_width() = width;
function psu_mount_height() = height;

// This shape is used to hollow out the power supply cage
module cage_hollow(dims, s) {
    union() {
        scale([s, 1, 1])
            cube(dims, center=true);
        scale([1, s, 1])
            cube(dims, center=true);
    }
}

module psu_mount_stl() {
    stl("psu_mount");

    difference() {
        translate([0, 0, 0])
            cube([length, width, height], center=true);
        cage_hollow(psu_dims, 1.2);
    }
}

module psu_assembly()
assembly("psu") {
    translate([0, 0, frame_thickness])
        psu(psu_type);

    render()
        psu_mount_stl();
}

if ($preview)
    psu_assembly();
