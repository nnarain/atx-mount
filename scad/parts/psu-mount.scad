include <../NopSCADlib/lib.scad>
include <../vitamins/psu-antec.scad>
include <../vitamins/motherboards.scad>

use <../NopSCADlib/psu.scad>
use <../NopSCADlib/psus.scad>

psu_type = EA550G_PRO;

psu_dims = [psu_length(psu_type), psu_width(psu_type), psu_height(psu_type)];

// Thickness of the outer frame
frame_thickness = 10;
// Clearance for the PSU in the frame
clearance = 2;
// Height of guide rails and back stop
rail_height = 5;
// The extra length needed to overlap with mounting holes
excess_width = 10;
// Depth for screw holes
screw_depth = 10;

length = psu_dims[0] + (frame_thickness * 2);
width = psu_dims[1] + (frame_thickness * 2) + excess_width;
height = psu_dims[2] + (frame_thickness * 2);

function psu_type() = psu_type;
function psu_mount_length() = length;
function psu_mount_width() = width;
function psu_mount_height() = height;


module psu_mount_stl() {
    stl("psu_mount");

    union() {
        difference() {
            cube([length, width, height]);
            cage_hollow(psu_dims);
            fan_hollow();
            motherboard_screw_holes();
        }
        rails();
    }
}

module fan_hollow() {
    x_offset = psu_length(psu_type) / 2 + frame_thickness;
    y_offset = psu_width(psu_type) / 2 + frame_thickness;
    z_offset = psu_height(psu_type) + frame_thickness;

    // echo(psu_face_fan(psu_faces(psu_type)[1]));
    hole_radius = 65;

    translate([x_offset, y_offset, z_offset])
        cylinder(r=hole_radius, h=frame_thickness, center=false);
}

// This shape is used to hollow out the power supply cage
module cage_hollow(dims) {
    union() {
        translate([0, frame_thickness, frame_thickness])
            cube([dims[0] + frame_thickness * 2, dims[1], dims[2] + clearance]);
        translate([frame_thickness, 0, frame_thickness])
            cube([dims[0], width, dims[2] + clearance]);
    }
}

module rails() {
    // Side rails
    // translate([0, frame_thickness - 0.001, frame_thickness])
    translate([0, 0, frame_thickness - 0.001])
        cube([frame_thickness, width, rail_height]);
    translate([psu_length(psu_type) + frame_thickness, 0, frame_thickness - 0.001])
        cube([frame_thickness, width, rail_height]);
    // Back rail
    translate([0, psu_width(psu_type) + frame_thickness, frame_thickness - 0.001])
        cube([length, frame_thickness, rail_height]);
}

module motherboard_screw_holes() {
    for (p = motherboard_hole_positions(ATX))
        translate([motherboard_length(ATX), 0, psu_mount_height() - screw_depth + 0.001])
            rotate(90)
                translate([p[0], p[1]])
                    cylinder(r=motherboard_hole_radius(ATX), h=screw_depth);
}

module psu_assembly()
assembly("psu") {
    translate([psu_length(psu_type) / 2 + frame_thickness, psu_width(psu_type) / 2 + frame_thickness, frame_thickness])
        psu(psu_type);

    render()
        psu_mount_stl();
}

if ($preview)
    psu_assembly();
