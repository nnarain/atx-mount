// Motherboard
//
// @author Natesh Narain <nnaraindev@gmail.com>
// @date July 7th 2020

bind = 0.001; // Minor value to bind parts or break through surface TODO describe better...

function motherboard_dimensions(spec) = spec[0];
function motherboard_length(spec) = motherboard_dimensions(spec)[0];
function motherboard_width(spec) = motherboard_dimensions(spec)[1];
function motherboard_thickness(spec) = motherboard_dimensions(spec)[2];

function motherboard_hole_positions(spec) = spec[1];
function motherboard_hole_radius(spec) = spec[2];

function motherboard_io_shield_dimensions(spec) = spec[3];
function motherboard_io_shield_length(spec) = motherboard_io_shield_dimensions(spec)[0];
function motherboard_io_shield_width(spec) = motherboard_io_shield_dimensions(spec)[1];
function motherboard_io_shield_height(spec) = motherboard_io_shield_dimensions(spec)[2];

module io_shield(spec) {
    color("lightgrey")
        translate([0, motherboard_length(spec) - motherboard_io_shield_length(spec), motherboard_thickness(spec) - bind])
            cube([motherboard_io_shield_width(spec), motherboard_io_shield_length(spec), motherboard_io_shield_height(spec)]);
}

module mounting_holes(spec) {
    for(p = motherboard_hole_positions(spec)) {
        translate([p[0], p[1], -bind])
            cylinder(r=motherboard_hole_radius(spec), h=motherboard_thickness(spec) * 2);
    }
}

module board(spec) {
    color("dimgrey")
        difference() {
            cube([motherboard_width(spec), motherboard_length(spec), motherboard_thickness(spec)]);
            mounting_holes(spec);
        }
}

module motherboard(spec) {
    union() {
        board(spec);
        io_shield(spec);
    }
}

if ($preview)
    motherboard();
